---
date: '2009-06-15 18:35:42'
layout: post
slug: jmx4r-0-0-8-through-the-looking-glass
status: publish
title: 'jmx4r 0.0.8: "Through the Looking Glass"'
wordpress_id: '425'
tags:
- jmx
- jmx4r
- jruby
---

[jmx4r][jmx4r] 0.0.8 has just been released.

Why "Through the Looking Glass"?  
Until this version, jmx4r was a library which made it super easy to write _simple Ruby scripts to manage Java applications_ using JMX.

With this version, the perspective has changed, we went through the looking glass and are now on the other side: jmx4r makes it super easy to _directly manage Ruby applications_ by leveraging JRuby and the Java platform.

A 30-line example is worth 10,000 words:

{% highlight ruby %}
    #!/usr/bin/env jruby
    require 'rubygems'
    require 'jmx4r'
    
    # a regular Ruby object we want to manage
    class Foo < JMX::DynamicMBean
       operation "a polite management operation"
       parameter :string, "how do you want to be called?"
       returns :string
       def hello(name="world")
          "hello, #{name}!"
       end
    
       operation "double the value"
       parameter :long
       returns :long
       def double(value)
         value * 2
       end
    end
    
    # Java objects to register the Ruby object in the platform
    import java.lang.management.ManagementFactory
    import javax.management.ObjectName
    
    foo = Foo.new
    # each managed object needs an unique 'ObjectName'
    object_name = ObjectName.new "foo:type=Foo" 
    ManagementFactory.platform_mbean_server.register_mbean foo, object_name
    
    # we keep the script running to manage it using jconsole
    puts "open jconsole to manage foo registered under 'foo:type=Foo'"
    gets
    ManagementFactory.platform_mbean_server.unregister_mbean object_name
{% endhighlight %}    



Save this script and run it using JRuby (tested it with version 1.3.0):

    $  jruby bean.rb
    open jconsole to manage foo registered under 'foo:type=Foo'

That's it: you have a Ruby application which can be managed using any Java management console.

For example, if we start jconsole to manage the bean.rb script:

![jconsole_connection](http://jmesnil.net/weblog/wp-content/uploads/2009/06/jconsole_connection1.png)

In the MBeans tab, we can expand Foo to see the management operation:

![jconsole_operation](http://jmesnil.net/weblog/wp-content/uploads/2009/06/jconsole_operation1.png)

And we can finally invoke it (e.g. by pushing the `hello` or `double"` button) and get a result after the method is called on the Ruby object:

![jconsole_result](http://jmesnil.net/weblog/wp-content/uploads/2009/06/jconsole_result.png)

### How to manage a Ruby object

To be manageable from a management console, the Ruby object must inherit from
`JMX::DynamicMBean` 

Since Java is statically typed, you also need to give some hints to help Java calls the Ruby object.

Each method you want to expose as a _management operation_ must be annotated with:

* an `operation` (and an optional description)
* a list of `parameter` (with a mandatory type and optional name and description)
* a `returns` type

The `returns` and `parameter` type must be one of `:boolean, :byte, :int, :long, :float, :double, :list, :map, :set, :string, and :void`

For example, if we have a method which prints the name and age of an user, it can be minimally exposed as:

{% highlight ruby %}
       operation
       parameter :string
       parameter :int
       returns :void
       def display(name, age)
         puts "#{name} is #{age} years old
       end
{% endhighlight %}
    



Exposing Ruby attributes for management is _even simpler_:

{% highlight ruby %}
    class AttributeTypesMBean < JMX::DynamicMBean
       rw_attribute :my_attr, :string, "a read/write String attribute"
       r_attribute :another_attr, :int, "a readonly int attribute"
    
        ...
      end
{% endhighlight %}
    



the `rw_attribute` declares a Ruby attribute (using `attr_accessor`) which is also exposed for management and can be read and write from a management console. Likewise, `r_attribute` declares a read-only Ruby attribute  (using `attr_reader`) which can only be read from a management console.

[DynamicMBean RDoc][jmx4r-rdoc] contains a description of all these annotations.

Finally, the code to register/unregister the Ruby object is taken directly from the Java library using `ManagementFactory.platform_mbean_server` to access the Java Platform's MBean Server.  
Each managed object must be registered with an unique ObjectName that is created using the `javax.management.ObjectName` class (the [JMX Best Practices][jmx-practices] is a good start for an overview of JMX, the umbrella name for management in Java).


Most of this code was taken from the `jmx` module of [jruby-extras][jruby-extras].
I fixed some issues with it but, from now on, the remaining bugs are likely written by me!

jmx4r was a simple and small library to write Ruby scripts to manage Java applications.    
It is now also a simple and small library to manage _Ruby applications_.


With the success of [JRuby][jruby] and the rise of Ruby applications running on Java  such as [Torquebox][torquebox], [GitHub:fi][github-fi], etc., I believe it can be very useful to leverage the features provided by the Java platform to manage Ruby applications.

As usual, to get this new release, just update the rubygem:

    jruby -S gem install jmx4r

and do not hesitate to contribute:

    git clone [git://github.com/jmesnil/jmx4r.git][jmx4r]

[jmx4r]: http://github.com/jmesnil/jmx4r/
[jmx4r-rdoc]: http://jmx4r.rubyforge.org/doc/
[jruby-extras]: http://rubyforge.org/projects/jruby-extras/
[jruby]: http://jruby.org
[torquebox]: http://torquebox.org
[github-fi]: http://fi.github.com/ 
[jmx-practices]: http://java.sun.com/javase/technologies/core/mntr-mgmt/javamanagement/best-practices.jsp
