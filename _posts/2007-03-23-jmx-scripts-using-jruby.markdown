---
date: '2007-03-23 13:44:38'
layout: post
slug: jmx-scripts-using-jruby
status: publish
title: JMX Scripts using JRuby
wordpress_id: '148'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

[__update__: fixed Ruby script by using `ManagementFactory::newPlatformMXBeanProxy` instead of `MBeanServerInvocationHandler::newProxyInstance` based on [Daniel comment](http://jmesnil.net/weblog/2007/03/23/jmx-scripts-using-jruby/#comment-20200)]

I needed to write a script to automate the management of  a Java application using JMX which I could put in a crontab.

I found some explanation on how to script JMX in jconsole [with BeanShell](http://blogs.sun.com/jmxetc/entry/a_beanshell_plugin_for_jconsole) or [with Groovy](http://blogs.sun.com/sundararajan/entry/groovier_jconsole).
It's a good approach but:

* I want the scripts to be executable in a cron (and not from jconsole GUI)
* I'd prefer to write them in Ruby

It turns out that it is straightforward to write such scripts using [JRuby](http://jruby.codehaus.org/) and Java 5 or later.

To keep things simple, let say I want to write a script which will be called periodically to run the garbage collector on a long-running Java application.

First let use jconsole as our long-running application. We will start jconsole with all the System properties required to manage its JVM through JMX/RMI connector:


    
    
    jconsole -J-Dcom.sun.management.jmxremote \
             -J-Dcom.sun.management.jmxremote.port=3000 \
             -J-Dcom.sun.management.jmxremote.ssl=false \
             -J-Dcom.sun.management.jmxremote.authenticate=false
    



### gc.rb ###

The script to run the garbage collector is simple:


    
    
    module JMX
        require 'java'
        
        include_class 'java.util.HashMap'
        include_package 'java.lang.management'
        include_package 'javax.management'
        include_package 'javax.management.remote'
        
        url = JMXServiceURL.new "service:jmx:rmi:///jndi/rmi://localhost:3000/jmxrmi"
        connector = JMXConnectorFactory::connect url, HashMap.new
        mbsc = connector.mbean_server_connection
        
        memory_mbean = ManagementFactory::newPlatformMXBeanProxy mbsc, "java.lang:type=Memory", MemoryMXBean::java_class
        
        memory_mbean.verbose = !memory_mbean.verbose
        puts "verbose = #{memory_mbean.verbose}"
        
        memory_mbean.gc
    end
    



This `gc.rb` script is doing several things:

1. it `require 'java'` so our scripts will run only on JRuby.
2. it includes all the required classes and packages .
3. it connects to jconsole's MBeanServer using the "standard" JMX URL `service:jmx:rmi:///jndi/rmi://localhost:3000/jmxrmi`
4. it creates a proxy of the `MemoryMXBean` based on the MBeanServerConnection `mbsc` and the ObjectName `java.lang:type=Memory`
5.  for "fun", it toggles the `verbose` boolean of the `memory_mbean`
6. and finally, it runs the garbage collector by calling `memory_mbean.gc`

When we run the script: 


    
    
    $ jruby gc.rb
    verbose = true
    



we see that a gc has been performed by jconsole's JVM:


    
    
    [Full GC 3754K->3172K(6076K), 0.0895140 secs]
    [GC 3680K->3189K(6076K), 0.0008180 secs]
    [GC 3701K->3281K(6076K), 0.0016410 secs]
    [GC 3793K->3320K(6076K), 0.0014080 secs]
    ...
    



I just need to put the call to this script in my crontab and I'm done.

### MBeans in JRuby classpath ###

Writing such scripts works fine for most cases but there is a caveat: it requires to have the MBean Java class in JRuby classpath to be able to create a proxy using either `MBeanServerInvocationHandler::newProxyInstance` or `ManagementFactory::newPlatformMXBeanProxy` (if the MBean is a MXBean as it is the case in this script).

If you have access to the jar containing the MBeans, you just need to put it `$JRUBY_HOME/lib/` directory to be able to access it from Ruby scripts.

Still it should possible to map JMX API with Ruby metamodel to get rid of this requirement and develop "JMX-generic" scripts.  

### Next Step: Generic JMX Scripts ###

The next step would be to create Ruby objects representing JMX MBeans where their attributes & operations will be added dynamically to
the corresponding Ruby instances by examining the MBeanInfo.   
The previous example would look like:


    
    
    memory_mbean = MBeanObject.new mbsc, "java.lang:type=Memory"
    memory_mbean.verbose = !memory_mbean.verbose
    memory_mbean.gc
    



The big change will be that we will no longer require to have the MBeans in JRuby classpath making it simpler to manage many Java applications (e.g. Tomcat, JBoss, etc.)  
To be continued...
