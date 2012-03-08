---
date: '2007-08-07 13:24:20'
layout: post
slug: jmx4r-004-is-released
status: publish
title: jmx4r 0.0.4 is released
wordpress_id: '160'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

[jmx4r][jmx4r] 0.0.4 has just been released.  
jmx4r is a JRuby library which makes it super easy to write simple Ruby scripts to manage Java applications using JMX.

To get this new release, just update the rubygem: `jruby -S gem install jmx4r`

[All contributions][0.0.4-issues] to this new release were done by Skaar:


  * CompositeData behave like regular read-only Ruby Hash
  * custom classes can be loaded by `require` statements
  * custom JMX credentials are supported



[jmx4r]: http://code.google.com/p/jmx4r/
[0.0.4-issues]: http://code.google.com/p/jmx4r/issues/list?can=1&q;=label:Milestone-0_0_4&colspec;=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Summary&sort;=&x;=Milestone&y;=&cells;=tiles



## CompositeData as read-only Hash ##

[CompositeData][compositedata] are the open and interoperable way to return custom data structures from JMX.  
They now behave in jmx4r as regular read-only Ruby Hash.

For example, the JVM exposes its heap memory usage with such a composite data:

{% highlight ruby %}
    memory = JMX::MBean.find_by_name "java.lang:type=Memory"
    # heap is a CompositeData attribute
    heap = memory.heap_memory_usage
{% endhighlight %}
    



To list the name and values of the `heap` attribute, the code was:

{% highlight ruby %}
    heap.composite_type.key_set.each do |type|
        puts "#{type} : #{heap.get type}"
    end
{% endhighlight %}
    



and now it is simply:

{% highlight ruby %}
    heap.keys.each do |key|
        puts "#{key} : #{heap[key]}"
    end
{% endhighlight %}
    



## Classloading using `require` ##

A second contribution by Skaar was to fix a classloading problem.
In case you need to use custom classes in your JMX code, only classes loaded from JRuby's classpath were taken into account.
It is now possible to reference classes loaded using `require` statements.

## Custom JMX credentials ##

jmx4r now allow you to specify custom credentials used by JMX authentication (as specified by a [JMXAuthenticator][jmxauthenticator]) in addition to the "standard" `:login/:password` credentials:

{% highlight ruby %}
    creds = create_my_custom_credentials()
    # creds will be used by the JMXAuthenticator on the MBeanServer
    JMX::MBean.establish_connection :credentials => creds
{% endhighlight %}
    

   

[compositedata]: http://java.sun.com/j2se/1.5.0/docs/api/javax/management/openmbean/CompositeData.html
[jmxauthenticator]: http://java.sun.com/j2se/1.5.0/docs/api/javax/management/remote/JMXAuthenticator.html
