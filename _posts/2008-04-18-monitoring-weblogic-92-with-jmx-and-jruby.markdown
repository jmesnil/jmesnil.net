---
date: '2008-04-18 16:43:05'
layout: post
slug: monitoring-weblogic-92-with-jmx-and-jruby
status: publish
title: ⚑ Monitoring Weblogic 9.2 with JMX and JRuby
wordpress_id: '171'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

From [Tim Koopmans][tim]:

> After getting nowhere with lack luster HP support, I turned to the power of the Open Source community and  got a very simple script up and running to remotely monitor Weblogic JVM Performance and JMS queues using JMX and JRuby.
> 
> [...]
> 
> This script will enumerate JVM performance and also JMS queue depths in around 50 lines of code 

That's a good example of the conciseness that JRuby brings to the Java platform: in 50 lines of code, Tim connects to a remote Weblogic MBean server, retrieves attributes about memory usage and JMS queue and stores them in a CSV file.

[tim]: http://90kts.com/blog/2008/monitoring-weblogic-92-with-jmx-and-jruby/



