---
date: '2007-07-05 13:50:00'
layout: post
slug: tomcat-management-snippet-using-jmx4r
status: publish
title: Tomcat management using jmx4r
wordpress_id: '158'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

Something which is not obvious with the way [jmx4r][jmx4r] leverages JMX API and Ruby metaprogramming is that you can write simple scripts to manage a Java application _without any dependency on the MBeans exposed by the application_.

For simplicity, in my examples I always use MBeans exposed by the JVM but jmx4r works with any MBean even if its interface is unknown from the JVM running the management scripts.

Here is a simple example to manage [Tomcat][tomcat] using jmx4r.

Let's assume that we have Tomcat running locally and manageable remotely on port 3000 (without authentication):


    $ export CATALINA_OPTS="-Dcom.sun.management.jmxremote \
        -Dcom.sun.management.jmxremote.port=3000 \
        -Dcom.sun.management.jmxremote.ssl=false \
        -Dcom.sun.management.jmxremote.authenticate=false"
    $ ./bin/catalina.sh/run

We want to know among all the Web Modules running in Tomcat which ones are privileged and which ones are not.
The whole script to do so is:

    # tomcat_modules.rb
    require "rubygems"
    require "jmx4r"

    JMX::MBean.establish_connection :host => "localhost", :port => 3000

    web_modules = JMX::MBean.find_all_by_name "Catalina:j2eeType=WebModule,*"
    privileged, unprivileged = web_modules.partition { |m| m.privileged }
     
    puts "Privileged:\n"     + privileged.map   {|m| m.path }.join("\n  ")
    puts "Unprivileged:\n  " + unprivileged.map {|m| m.path }.join("\n  ")

Executing this script gives:

    $ jruby tomcat_modules.rb 
    Privileged:
      /balancer
      /manager
      /host-manager
    Unprivileged:
      /tomcat-docs
      /servlets-examples
      /jsp-examples
      
      /webdav


That's were using [JRuby][jruby] shines: it combines the simplicity of using directly the MBeans exposed by a Java application without having to bother with classes dependency.

Using Java to write a corresponding script means choosing your "poison":

* No class dependency but tedious (and unnatural) use of [MBeanServerConnection][mbsc] methods to interact with Tomcat MBeans
* Use directly Tomcat MBeans (thanks to [MBeanServerInvocationHandler][mbsih]) but you must take care having all their interfaces (and dependencies) in the class path of the JVM running the script

I can not thank enough both the JMX and JRuby guys which make it so simple to get the best of both worlds in jmx4r:

* _simple to use_ directly the MBeans API
* _simple to deploy_ without class dependency issues


[jmx4r]:  http://code.google.com/p/jmx4r/
[tomcat]: http://tomcat.apache.org/
[jruby]:  http://jruby.codehaus.org/
[mbsc]:   http://java.sun.com/j2se/1.5.0/docs/api/javax/management/MBeanServerConnection.html
[mbsih]:  http://java.sun.com/j2se/1.5.0/docs/api/javax/management/MBeanServerInvocationHandler.html
