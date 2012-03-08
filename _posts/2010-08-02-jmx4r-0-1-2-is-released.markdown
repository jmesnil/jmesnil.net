---
date: '2010-08-02 17:53:15'
layout: post
slug: jmx4r-0-1-2-is-released
status: publish
title: jmx4r 0.1.2 Is Released
wordpress_id: '1174'
tags:
- jmx4r
---

[jmx4r][jmx4r] 0.1.2 has just been released (jmx4r is a JRuby library which makes it super easy to write simple Ruby scripts to manage Java & JRuby applications using JMX).

* it fixes a bug in the `getAttributes()` method that is exposed by Ruby objects extending jmx4r's `DynamicMBean` class

I introduced the bug but it is one of the rare cases where I would still blame JMX API. Its [DynamicMBean][dynamic] interface has
two methods:

* `getAttribute(String attribute)`
* `getAttributes(String[] attributes)`

Following the [principle of least surprise][pols], I expected `getAttribute(String)` to return the value of the attribute and `getAttributes(String[])` to return a collection of the attribute values. But that's not the case. As expected `getAttribute(String)` returns the value of the attribute but `getAttributes(String[])` returns a `AttributeList` which is a list of `Attribute` objects (which in turns contains the name and value of an attribute).  
jmx4R 0.1.2 fixes the issue and make sure the methods return the correct objects.

JMX is one of my favorite Java API, simple, flexible and powerful at the same time. Its evolution made it both a bit uglier and more convenient (I wish open types were more simpler to use and less verbose to declare). Providing a library to use JMX in JRuby applications is the perfect match between a simple and powerful library (JMX) and a simple and powerful language (Ruby) on a <strike>simple and</strike> powerful platform (JVM).

From time to time, I receive mails inquiring about the status of jmx4r.  
I no longer use jmx4r in my daily job and it is not actively developed. However it is actively maintained. If you find bugs, I can release a new version quite fast. jmx4r users are awesome and most of the time, they provide patches when they report bugs.  
If you have ideas for improvements, do not hesitate to send me a mail or fork the project. Most recent contributions were done through forks on GitHub.

Once again, thanks to all the contributors and users who help make jmx4r even more useful!

As usual, to get this new release, just update the rubygem:

    jruby -S gem install jmx4r

and do not hesitate to contribute:

    git clone git://github.com/jmesnil/jmx4r.git

[jmx4r]: http://github.com/jmesnil/jmx4r
[dynamic]: http://download.oracle.com/javase/1.5.0/docs/api/javax/management/DynamicMBean.html
[pols]: http://en.wikipedia.org/wiki/Principle_of_least_surprise
