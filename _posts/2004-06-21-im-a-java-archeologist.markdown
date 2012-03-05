---
date: '2004-06-21 15:51:13'
layout: post
slug: im-a-java-archeologist
status: publish
title: ⚑ I'm a Java archeologist
wordpress_id: '11'
tags:
- java
---

For my current mission, I've to port a web application developped for [Tomcat](http://jakarta.apache.tomcat/) 3.2 to Tomcat 4.x. Not a big deal, I thought...  

Unfortunately, there is a minor change between Tomcat 3.2 and 4.x which made my working life a hell today: by default, Tomcat 3.2 imports `java.util.Vector` in the JSP page while Tomcat 4.x doesn't.  

Since almost all the JSP pages of the application use `Vector` to iterate the data, I've to check every JSP page and explicitely add the import statement to make it work on Tomcat 4.x




I've got the weird feeling of being a Java archeologist: Java is not that old but it's still quite amazing to see the differences between the code written in early Java (and JSP 1.0 for the circumstances) and current Java state of the art.  
I wondered how it'll feel when Java 1.5 (generics, metadata, concurrency) is be used everyday?



