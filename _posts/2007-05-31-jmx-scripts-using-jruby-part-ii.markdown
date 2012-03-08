---
date: '2007-05-31 10:55:03'
layout: post
slug: jmx-scripts-using-jruby-part-ii
status: publish
title: JMX Scripts using JRuby -- Part II
wordpress_id: '150'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

__update__: [a more Ruby-esque version using Rails idioms](http://revolutiononrails.blogspot.com/2007/05/ruby-esque-jmx-part-2.html) by [Aaron Batalion](http://revolutiononrails.blogspot.com/)

__update__: updated Ruby script to use `instance_eval` and `define_method` instead of `eval` based on a [poignant][poignant] explanation of [eval-less metaprogramming][eval-less].

In [Part I][part-1], I created a [JRuby][jruby] script to manage a Java application using JMX.

In this entry, I'll explain how to remove the dependency on the MBean proxies by taking advantage of Ruby to dynamically add the MBean attributes to a Ruby object representing the MBean.

[poignant]:  http://poignantguide.net/ruby/chapter-6.html#section3
[eval-less]: http://redhanded.hobix.com/bits/evalLessMetaprogramming.html 
[part-1]:    http://jmesnil.net/weblog/2007/03/23/jmx-scripts-using-jruby/
[jruby]:     http://jruby.codehaus.org

### MBean proxies ###

Using MBean proxies (using either [`ManagementFactory.newPlatformMXBeanProxy()`][mngmt-factory] or [`MBeanServerInvocationHandler.newProxyInstance()`][mbsih]) is always the simplest way to interact with MBeans.
However it also means that the MBean interfaces must be available to the JMX client. This can be sometimes problematic.  
For example, to use a proxy on your MBean (as opposed to the JVM MBeans that I'm using in my examples for convenience), you must add the jar containing your MBeans in JRuby classpath.  
If it is not a problem, good news, go for it.  
However if it makes the setup too complex, let's try to break this dependency.

### MBean attributes ###

To make it simple, I'll focus on the MBean attributes. We will create a Ruby object which makes it simple and elegant to read the value of a MBean attribute without creating a proxy of the MBean (by simple & elegant, I mean something else than calling directly [`MBeanServerConnection.getAttribute(ObjectName, String)`][mbsc]).

We will again use jconsole as our managed java application (see [Part I][part-1] to start jconsole with all System properties required to manage it remotely).

Going directly to the conclusion, the code to display a list of all loggers defined by `java.util.logging` is

{% highlight ruby %}
# connect to jconsole MBeanServer
url = JMXServiceURL.new "service:jmx:rmi:///jndi/rmi://localhost:3000/jmxrmi"
connector = JMXConnectorFactory::connect url, HashMap.new
mbsc = connector.mbean_server_connection

logging = MBean.new mbsc, "java.util.logging:type=Logging"
# list all Loggers
logging.LoggerNames.each do | logger_name |
    puts logger_name
end
{% endhighlight %}

Running this code will display all loggers:

{% highlight sh %}
sun.rmi.client.call
java.awt.ContainerOrderFocusTraversalPolicy
javax.management.remote.rmi
javax.swing.SortingFocusTraversalPolicy
sun.rmi.server.call
sun.rmi.transport.tcp
...
{% endhighlight %}

Where is the magic? It is in 

{% highlight ruby %}
logging = MBean.new mbsc, "java.util.logging:type=Logging"
{% endhighlight %}

### JRuby's MBean class ###

`MBean` is a Ruby class which creates objects with specific methods to access all the attributes associated to the `ObjectName` passed in parameter using the `MBeanServerConnection` to connect to a remote MBeanServer.

What does its code look like?

{% highlight ruby %}
class MBean
    include_class 'javax.management.ObjectName'

    def initialize(mbsc, object_name)
        @mbsc = mbsc
        @object_name = ObjectName.new object_name
        info = mbsc.getMBeanInfo @object_name
        info.attributes.each do | mbean_attr |
            self.class.instance_eval do 
                define_method mbean_attr.name do
                    @mbsc.getAttribute @object_name, "#{mbean_attr.name}"
                end
            end
        end
    end
end
{% endhighlight %}

This class only defines a constructor `initialize` which accepts a `MBeanServerConnection` and a String representing an `ObjectName` which is used to create a `@object_name` field.

It retrieves the `MBeanInfo` associated to the `@object_name` thanks to `@mbsc`.
It then iterates on the `MBeanAttributeInfo` using `info.attributes`.

That's in this iterator that the magic happens:

{% highlight ruby %}
self.class.instance_eval do 
    define_method mbean_attr.name do
        @mbsc.getAttribute @object_name, "#{mbean_attr.name}"
    end
end
{% endhighlight %}

It calls [`instance_eval`][instance_eval] to add a method to the instance class.   
This method is created using `define_method` with `mbean_attr.name` as the method name. It returns the value of the mbean attribute by calling `@mbsc.getAttribute` for the given `mbean_attr.name` of the `@object_name` of the MBean.

What does this mean? Executing `logging = MBean.new mbsc, "java.util.logging:type=Logging"` will create the `logging` object and add a method to this object to access the `LoggerNames` attribute:

{% highlight ruby %}
    def LoggerNames
        @mbsc.getAttribute @object_name, "LoggerNames"
    end
{% endhighlight %}

### Conclusion ###

Complete code is in [jmx-attr.rb][jmx-attr.rb].

With few lines of code, it is possible to access MBean attributes in a simple way. 

However, to have the same level of functionalities than using MBean proxies, we still need to be able to write attributes and invoke operations. Let's keep that for other entries.

[mngmt-factory]: http://java.sun.com/j2se/1.5.0/docs/api/java/lang/management/ManagementFactory.html#newPlatformMXBeanProxy(javax.management.MBeanServerConnection,%20java.lang.String,%20java.lang.Class)
[mbsih]: http://java.sun.com/j2se/1.5.0/docs/api/javax/management/MBeanServerInvocationHandler.html#newProxyInstance(javax.management.MBeanServerConnection,%20javax.management.ObjectName,%20java.lang.Class,%20boolean)
[mbsc]: http://java.sun.com/j2se/1.5.0/docs/api/javax/management/MBeanServerConnection.html#getAttribute(javax.management.ObjectName,%20java.lang.String)
[instance_eval]: http://www.ruby-doc.org/core/classes/Object.html#M000336
[jmx-attr.rb]: http://jmesnil.net/downloads/jmx-attr.rb
