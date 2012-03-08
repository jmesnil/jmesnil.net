---
date: '2007-06-11 17:23:57'
layout: post
slug: jmx4r-a-jmx-libary-for-jruby
status: publish
title: jmx4r, a JMX Libary for JRuby
wordpress_id: '155'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

Just in time for the release of [JRuby 1.0][jruby] and following my experiments with writing JRuby scripts to manage remote applications using JMX ([part I][part-1] & [II][part-2]), I created [jmx4r][jmx4r], a simple library which makes it super easy to write such scripts.

For example, to trigger a Garbage Collection on a remote Java application , the whole script is:

{% highlight ruby %}
require 'java'
require 'jmx4r'

memory = JMX::MBean.find_by_name "java.lang:type=Memory"
memory.verbose = true
memory.gc
{% endhighlight %}
Simple enough, isn't it?

[jruby]:	http://jruby.codehaus.org
[part-1]:	http://jmesnil.net/weblog/2007/03/23/jmx-scripts-using-jruby/
[part-2]:	http://jmesnil.net/weblog/2007/05/31/jmx-scripts-using-jruby-part-ii/
[jmx4r]:	http://code.google.com/p/jmx4r/

## JMX Connection ##

By default, jmx4r expects to connect to the remote MBean Server on localhost using the [standard JMX Service URL][jmx-std-url].
Otherwise, it is possible to set the host and port of the remote MBean Server:

{% highlight ruby %}
JMX::MBean.establish_connection :host => "localhost", :port => 3000
{% endhighlight %}

## Attributes & Operations naming convention ##

JMX attributes are available on the JRuby objects but their names are changed to be *snake_cased* instead of *CamelCased*.  
For example, the `LoadedClassCount` attribute of the `java.lang:type=ClassLoading` MBean is available as the `loaded_class_count` attribute on the corresponding JRuby object.

Ditto for the operations:

{% highlight ruby %}
logging = JMX::MBean.find_by_name "java.util.logging:type=Logging"
logging.logger_names.each do |logger_name|
    logging.set_logger_level logger_name, "INFO"
end
{% endhighlight %}

The `set_logger_level` method corresponds to the `setLoggerLevel` MBean operations.

## Features List ##

For now, the features of jmx4r are:

* read MBean attributes:
        
{% highlight ruby %}
memory = JMX::MBean.find_by_name "java.lang:type=Memory"
puts "verbose : #{memory.verbose}"
{% endhighlight %}

* write MBean attributes (provided they are writable):
        
{% highlight ruby %}
memory = JMX::MBean.find_by_name "java.lang:type=Memory"
memory.verbose != memory.verbose
{% endhighlight %}

* invoke MBean operations (provided the parameters types are simple):

{% highlight ruby %}
memory = JMX::MBean.find_by_name "java.lang:type=Memory"
memory.gc

logging = JMX::MBean.find_by_name "java.util.logging:type=Logging"
logging.set_logger_level "global", "INFO"
{% endhighlight %}

* query for MBeans:
 
{% highlight ruby %}
memory_pools = JMX::MBean.find_all_by_name "java.lang:type=MemoryPool,*"
memory_pools.each { |mem_pool| puts mem_pool.name }
{% endhighlight %}
        
* get the ObjectName correponding to a MBean:

{% highlight ruby %}
memory_pools = JMX::MBean.find_all_by_name "java.lang:type=MemoryPool,*"
memory_pools.each { |mem_pool| puts mem_pool.object_name }
{% endhighlight %}

Next steps are:

 * provide comprehensive tests
 * document the library
 * make a gem to simplify its deployment

[jmx-std-url]: http://java.sun.com/j2se/1.5.0/docs/guide/management/agent.html#connecting
