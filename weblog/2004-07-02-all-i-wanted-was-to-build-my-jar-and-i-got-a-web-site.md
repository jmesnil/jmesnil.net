---
date: '2004-07-02 13:58:55'
layout: post
slug: all-i-wanted-was-to-build-my-jar-and-i-got-a-web-site
status: publish
title: "All I wanted was to build my jar and I got a web site"
wordpress_id: '35'
tags:
- java
---

Via [Dion](http://www.almaer.com/blog/archives/000249.html), my quote of the week : 




> All I wanted was to build my jar and I got a web site.

Jonas Boner, AspectWerkz/BEA




I see more and more projects which use [Maven](http://maven.apache.org) as their build process also use Maven to _run_ their applications...  

Maven is a build process with (some) advantages and (lots of) inconveniences but it's not made to run applications. Yes, it is possible to do it but I find insane to have to download Maven, set it up just to run another application which has all its dependencies already downloaded... Maybe (crazy thought!) Maven and [Ant](http://ant.apache.org) could be used in a complementary way:







  1. Maven for the build process (but IMHO Ant 1.6 is a better choice)


  2. Ant to run the application




Or maybe, even better, we could improve `java -jar` and use scripting (Jython, Groovy,...) to get rid of Ant or Maven to run the applications (cf. [Jetty](http://jetty/mortbay.org) or [Eclipse](http://www.eclipse.org/)).
