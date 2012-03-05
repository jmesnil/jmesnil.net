---
date: '2008-08-01 18:49:50'
layout: post
slug: jmx4r-006-is-released
status: publish
title: ⚑ jmx4r 0.0.6 is released
wordpress_id: '213'
tags:
- java
- jmx
- jmx4r
- jruby
---

[jmx4r][jmx4r] 0.0.6 has just been released (jmx4r is a JRuby library which makes it super easy to write simple Ruby scripts to manage Java applications using JMX).

This release adds helper methods to make it more natural to work with [TabularData][tabulardata] attributes and [ObjectName][objectname] properties

### Iterate over TabularData attribute ###

TabularData attributes now behave like regular Ruby [Enumerable][enumerable]:


    
    
    #!/usr/bin/env jruby
    require 'rubygems'
    require 'jmx4r'
     
    runtime = JMX::MBean.find_by_name "java.lang:type=Runtime"
    # runtime.system_properties is a TabularData
    runtime.system_properties.each do | sysprop | 
      puts "#{sysprop["key"]} = #{sysprop["value"]}"
    end
    




### ObjectName properties ###

ObjectName properties can now be accessed using the `[]` method:


    
    
    #!/usr/bin/env jruby
    require 'rubygems'
    require 'jmx4r'
    require 'jconsole'
     
    mem_pools = JMX::MBean.find_all_by_name "java.lang:type=MemoryPool,*"
    mem_pools.each do |pool|
      # print the 'name' property of the pool's ObjectName
      puts pool.object_name["name"]
    end
    



As usual, to get this new release, just update the rubygem:

    jruby -S gem install jmx4r

and do not hesitate to contribute:

    git clone git://github.com/jmesnil/jmx4r.git

[jmx4r]: http://code.google.com/p/jmx4r/
[tabulardata]: http://java.sun.com/j2se/1.5.0/docs/api/javax/management/openmbean/TabularData.html
[objectname]: http://java.sun.com/j2se/1.5.0/docs/api/javax/management/ObjectName.html
[enumerable]: http://www.ruby-doc.org/core/classes/Enumerable.html
