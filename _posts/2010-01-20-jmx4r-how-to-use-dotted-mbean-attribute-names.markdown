---
date: '2010-01-20 18:56:15'
layout: post
slug: jmx4r-how-to-use-dotted-mbean-attribute-names
status: publish
title: 'jmx4r: How to Use Dotted MBean Attribute Names'
wordpress_id: '893'
tags:
- jmx4r
---

An user reported an [issue][issue] with [jmx4r][jmx4r] because he was not able to access a MBean attribute.

> See for example attribute names under the amx:j2eeType=X-MonitoringDottedNames,name=na mbean of a GlassFish instance.
>
> Trying to get the value of an attribute like `server.http_service.file_cache.maxentries_lastsampletime` doesn't work. 

He is right that jmx4r does not work with dotted attributes. For example, this code will fail:

{% highlight ruby %}
    server = JMX::MBean.find_by_name "amx:j2eeType=X-MonitoringDottedNames,name=na"
    puts server.http_service.file_cache.maxentries_lastsampletime
{% endhighlight %}    

JMX supports dotted attributes but they can not be used directly with jmx4r because of Ruby syntax.  
Ruby will read `server.http_service.file_cache.maxentries_lastsampletime` and will rightfully call `http_service` on the 
`server` object first. But there is no such method or attribute and the call will fail.  

To circumvent this issue and be able to use jmx4r with dotted MBean attributes, you can use Ruby [Object#send][send].

Instead of 

{% highlight ruby %}
    server.http_service.file_cache.maxentries_lastsampletime
{% endhighlight %}    

you will have to use

{% highlight ruby %}
    server.send("http_service.file_cache.maxentries_lastsampletime")
{% endhighlight %}    

This looks ugly but it works.


The user proposed to have jmx4r objects implement `[]` and work like a Hash to support dotted names.
I am not convinced that such edge cases are worth supporting `[]` but if you think otherwise, do not hesitate to vote for this [feature][issue] and I will add it to jmx4r.


[issue]: http://github.com/jmesnil/jmx4r/issues#issue/1
[jmx4r]: http://github.com/jmesnil/jmx4r/
[send]: http://ruby-doc.org/core/classes/Object.html#M000332
