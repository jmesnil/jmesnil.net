---
date: '2008-04-14 15:48:06'
layout: post
slug: jmx4r-005-is-released-with-support-for-custom-jmx-url
status: publish
title: jmx4r 0.0.5 is released with support for custom JMX URL
wordpress_id: '169'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

[jmx4r][jmx4r] 0.0.5 has just been released (jmx4r is a JRuby library which makes it super easy to write simple Ruby scripts to manage Java applications using JMX).

There is only one enhancement to this release but it is an important one: you can now [specify a custom JMX URL][issue-7] to connect to a MBean Server.


Before this release, the URL was hard-wired to connect using the [JMX URL][sun-jmx-url] defined by Sun `service:jmx:rmi:///jndi/rmi://#{host}:#{port}/jmxrmi`.

This means it was not possible to use jmx4r to connect to a MBean server which used another URL or another connector that RMI/JRMP.

With this release, you can now fully specify the url:

{% highlight ruby %}
        url = "service:jmx:rmi:///jndi/iiop://node1:7001/weblogic.management.mbeanservers.runtime"
        JMX::MBean.establish_connection :url => url
{% endhighlight %}
    



As an example, the code above can be used to connect to a [Weblogic server using RMI/IIOP][weblogic-jmx].

When the `:url` argument is used, `:host`and `:port` arguments are ignored. If you're connecting to a Sun JRE, it is still simpler to specify only `:host` & `:port` though.
 
This enhancement was proposed by [Tim Koopmans][tim]. Thanks Tim!

As usual, to get this new release, just update the rubygem:


    
    
    jruby -S gem install jmx4r
    



[jmx4r]: http://code.google.com/p/jmx4r/
[issue-7]: http://code.google.com/p/jmx4r/issues/detail?id=7&can;=1
[sun-jmx-url]: http://java.sun.com/j2se/1.5.0/docs/guide/management/agent.html#connecting
[weblogic-jmx]: http://www.performanceengineer.com/monitoring/monitoring-weblogic-using-jmx
[tim]: http://www.90kts.com/
