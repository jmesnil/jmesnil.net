---
date: '2005-02-21 11:41:00'
layout: post
slug: jotm-203-released-tck-recovery
status: publish
title: JOTM 2.0.3 released - TCK + Recovery
wordpress_id: '79'
tags:
- java
---

It has not made to the headlines but this is a significant achievement.






JOTM is an Open Source (BSD-licensed) implementation of the [JTA](http://java.sun.com/products/jta/) and [JTS](http://java.sun.com/products/jts/) API to provide transaction management in Java/J2EE applications (I lead this project for some time but eventually passed the lead to David Egolf due to other job commitments).





This release was used by the J2EE server [JOnAS](http://jonas.objectweb.org/) to pass the J2EE TCK. It also includes a recovery log based on the [HOWL](http://howl.objectweb.org/) project.






I believe it is a great step for Open Source J2EE applications for several reasons:



  
  * As far as I know, it is the first implementation of an _Open Source_ transaction manager which supports recovery (there is some work on that in  [JBoss JTA](http://www.jboss.org/wiki/Wiki.jsp?page=JBossJTA) and nothing for [Tyrex](http://tyrex.sourceforge.net/))

  
  * the HOWL project is the result of the collaboration between the [ObjectWeb](http://www.objectweb.org/) and [Apache](http://www.apache.org/) communities. [Coopetition](http://www.jmesnil.net/weblog/2004/11/c-jdbc-wins-apachecon-derby-code.html) is a Good Thing

  
  * There is a good opportunity for JOTM to be used as the default transaction manager in [Geronimo](http://geronimo.apache.org)





Congratulations to the JOTM and HOWL teams. Keep up the good work!

