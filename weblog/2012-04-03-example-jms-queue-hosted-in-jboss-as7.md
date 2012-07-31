---
layout: post
title: "Example of a JMS Queue Hosted in JBoss AS7"
date: '2012-04-03 11:22:16'
category: 
link: https://github.com/jmesnil/queue-as7
tags: []
---

To familiarize myself with running tests in [JBoss AS7][jbossas], I have created the smallest Maven project which uses [Arquillian][arquillian] to manage an instance of JBoss AS7 with [HornetQ][hornetq] enabled, deploy a JMS queue in it and run a test.

Works from the shell or Eclipse.


[jbossas]: http://www.jboss.org/jbossas
[arquillian]: http://www.jboss.org/arquillian
[hornetq]: http://www.jboss.org/hornetq


