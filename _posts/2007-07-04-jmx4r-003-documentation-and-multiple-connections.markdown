---
date: '2007-07-04 11:22:01'
layout: post
slug: jmx4r-003-documentation-and-multiple-connections
status: publish
title: ⚑ jmx4r 0.0.3, documentation and multiple connections
wordpress_id: '157'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

[jmx4r][jmx4r] 0.0.3 has just been released.  
jmx4r is a JRuby library which makes it super easy to write simple Ruby scripts to manage Java applications using JMX.



Two new features in this release:







  1. some much-needed [documentation](http://jmx4r.rubyforge.org/doc/)


  2. as [requested](http://code.google.com/p/jmx4r/issues/detail?id=2&can=1&q=) by [Brian McCallister](http://kasparov.skife.org/blog/), I've modified the code so that it is now possible
to write a script to manage many Java applications at the same time.





For example, the script to trigger a garbage collection on a cluster of Java applications at the same time (quite a bad idea but a simple one):




    
    <code>port = 1090
    hosts = ["node1", "node2", "node3", "node4"]
    hosts.each do |h|
        memory = JMX::MBean.find_by_name "java.lang:type=Memory", :host => h, :port => port
        memory.gc
    end
    </code>





Quite simple, isn't it?



[jmx4r]: http://code.google.com/p/jmx4r/






`JMX::MBean#find_by_name` and `JMX::MBean#find_all_by_name` now accept an optional hash where you can specify specific information related to the connection to use (`:host`, `:port`, `:username`, `:password` or `:connection`) as described in the [documentation](http://jmx4r.rubyforge.org/doc/classes/JMX/MBean.html#M000009). Otherwise, a global connection will be used.





A complete [example](http://jmx4r.googlecode.com/svn/trunk/examples/memory_on_many_nodes.rb) shows how to display memory usage on 3 Java applications _before_ and _after_ a garbage collection is triggered.




    
    <code>$ jruby -Ilib examples/memory_on_many_nodes.rb
    
    Before GC:
    +----------------+----------------+----------------+
    | Node           |      Heap Used |  Non Heap Used |
    +----------------+----------------+----------------+
    | localhost:3000 |        1264328 |       14414808 |
    | localhost:3001 |        1345632 |       14465192 |
    | localhost:3002 |        1405072 |       14501936 |
    +----------------+----------------+----------------+
    After GC:
    +----------------+----------------+----------------+
    | Node           |      Heap Used |  Non Heap Used |
    +----------------+----------------+----------------+
    | localhost:3000 |        1142304 |       14421184 |
    | localhost:3001 |        1205040 |       14476312 |
    | localhost:3002 |        1218928 |       14506672 |
    +----------------+----------------+----------------+
    </code>





As usual, the simplest way to install it is by using RubyGems: `jruby -S gem install **jmx4r**`.
