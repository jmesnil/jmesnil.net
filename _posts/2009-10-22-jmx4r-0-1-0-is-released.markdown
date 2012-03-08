---
date: '2009-10-22 18:31:29'
layout: post
slug: jmx4r-0-1-0-is-released
status: publish
title: jmx4r 0.1.0 Is Released
wordpress_id: '870'
tags:
- java
- jmx
- jmx4r
- jruby
- misc
---

[jmx4r][jmx4r] 0.1.0 has just been released (jmx4r is a JRuby library which makes it super easy to write simple Ruby scripts to manage Java applications using JMX).

* fixed compatibility with Rake 0.8.7 (thanks [Dan](http://twitter.com/jrubyist)!)
* fixed dynamic mbean issues where attributes and methods were added to *all* the dynamic mbeans in the thread (thanks [Munesse](http://muness.blogspot.com/)!)

There is also two new features:

* support for Java CamelCase style in addition to Ruby snake_case (thanks again to Dan)


    
    
    logging = JMX::MBean.find_by_name "java.util.logging:type=Logging"
    
    # Ruby syntax works
    logging.set_logger_level "global", "FINEST"
    # Java syntax works too
    logging.setLoggerLevel "global", "FINEST"
    



* Connection to a local JVM (thanks to [Mr ohtsuka](http://github.com/sat13f)).
  You can now connect to a JVM running on the same machine without adding the `com.sun.management.jmxremote` system properties.

For example, start an instance of jconsole without any additional system properties:


    
    
    $ jconsole &
    



You can now manage this Java application locally:


    
    
    require 'rubygems'
    require 'jmx4r'
    
    # :command is a regexp corresponding to the Java process to connect to
    JMX::MBean.establish_connection :command => /JConsole/
    memory = JMX::MBean.find_by_name "java.lang:type=Memory"
    memory.gc            
    



In addition to the previous `:host`, `:port` and `:url` arguments that you can pass to establish a JMX connection, there is now `:command` which must be a regular expression corresponding to the local Java process you want to connect to. You can find the name of the process using `jps`:


    
    
    $ jps
    4255 JConsole
    4395 Jps
    



You can connect to a local Java application running on Java 5 or 6. Is someone interested to contribute support for JDK7 too?

Once again, thanks to all the contributors and users who help make jmx4r even more useful!

As usual, to get this new release, just update the rubygem:

    jruby -S gem install jmx4r

and do not hesitate to contribute:

    git clone git://github.com/jmesnil/jmx4r.git

[jmx4r]: http://github.com/jmesnil/jmx4r
