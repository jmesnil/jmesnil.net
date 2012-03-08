---
date: '2004-08-20 10:11:57'
layout: post
slug: activemq-10-is-released
status: publish
title: ActiveMQ 1.0 is released
wordpress_id: '38'
tags:
- java
---

I've worked on an Open Source JMS implementation ([JORAM](http://joram.objectweb.org)) before and I was quite curious to see what ActiveMQ would bring to the table compared to existing implementations (e.g. [OpenJMS](http://openjms.sf.net/) or [JBossMQ](http://www.jboss.org/developers/projects/jboss/jbossmq.jsp)).




I was mostly pleased with the way ActiveMQ leverages other Open Source efforts (e.g. for transport protocol or message persistence), brings some fresh and interesting ideas (such as their REST API) and plays nice with other projects such as [Geronimo](http://geronimo.apache.org/), [Axis](http://ws.apache.org/axis/) or [Spring](http://www.springframework.org/).




The project is still young and may need more eyes before being ready for production but I believe it will quickly become a real contender in the Open Source field:





  
  * JBossMQ has been certified as a part of JBoss but I'm not aware of any standalone use of JBossMQ.

  
  * JORAM will also be J2EE certified as a part of JOnAS. It can be used as a standalone MOM but it has some limitations (e.g. message persistence) which has hampered its adoption
 
  
  * OpenJMS is a joke




I'll talk later about the fact that there isn't yet an Open Source ESB project which has gained momentum. An Open Source JMS implementation is a key part of such an ESB initiative. It seems to me that ActiveMQ with all its qualities, its willingness to play nice with other Open Source communities and its Apache 2.0 license is a likely candidate to be a key component of such an ESB project.




Anyway, congratulations to the ActiveMQ guys and keep up the good work!
