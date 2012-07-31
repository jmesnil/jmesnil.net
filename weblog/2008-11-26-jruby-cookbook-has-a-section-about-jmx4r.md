---
date: '2008-11-26 17:42:51'
layout: post
slug: jruby-cookbook-has-a-section-about-jmx4r
status: publish
title: JRuby Cookbook Has a Section About jmx4r
wordpress_id: '398'
tags:
- book
- java
- jmx
- jmx4r
- ruby
---

[![](http://oreilly.com/catalog/covers/9780596519803_cat.gif)](http://oreilly.com/catalog/9780596519803/)

I noticed today that O'Reilly just released [JRuby Cookbook][jruby-cookbook]. I have a few ideas I'd like to implement using [JRuby][jruby] and I was browsing the [table of contents][toc] to check if the book could be helpful.  

I was pleasantly surprised to see that it contains a section about "Performing Remote Management with JMX" using [jmx4r][jmx4r] (you can read a preview of the section by expanding it from the [table of contents][toc]).

I'm obviously biased but I  deeply believe that a small library such as jmx4r (less than 200 SLOC for the [main file][jmx4r.rb] and 1/3 are comments) shows what the combination of Ruby and Java can achieve.  
JRuby leverages the strong Java runtime (with its garbage collection and hotspot) and allows to access a wide range of Java libraries with all the strengths of the Ruby language.

For example, in jmx4r case, I extensively use Ruby metaprogramming toolset to dynamically create the properties and methods correponding to the MBean attributes and operations.

There are also other [stories][jruby-success-story] which demonstrates what JRuby brings to the table coming from the C-Ruby world.

I'm looking forward to read this cookbook and write some ruby code built on top of the Java platform.

[jruby-cookbook]: http://oreilly.com/catalog/9780596519803/
[toc]: http://oreilly.com/catalog/9780596519803/toc.html
[jmx4r]: http://code.google.com/p/jmx4r/
[jmx4r.rb]: http://github.com/jmesnil/jmx4r/tree/master/lib/jmx4r.rb
[jruby]: http://jruby.codehaus.org/
[jruby-success-story]: http://syntatic.wordpress.com/2008/11/25/the-closet-jrubyists/
