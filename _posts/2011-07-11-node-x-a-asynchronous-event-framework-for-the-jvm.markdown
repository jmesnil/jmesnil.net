---
date: '2011-07-11 13:08:57'
layout: post
slug: node-x-a-asynchronous-event-framework-for-the-jvm
status: publish
title: ⚑ node.x, a Asynchronous Event Framework for the JVM
wordpress_id: '1714'
tags:
- java
---

[Tim Fox][nodex]:

> What is Node.x?
>
> * A general purpose framework that uses an asynchronous event based style for building highly scalable network or file system aware applications
> * Runs on the JVM.
> * Everything is asynchronous.
> * Embraces the style of node.js and extends it to the JVM. Think node.js on steroids. Plus some.
> * Polyglot. The same (or similar) API will be available in multiple languages: Ruby, Java, Groovy, (Python?, JS?, Clojure?), etc
> * Goes with the recent developments with InvokeDynamic in Java 7 and bets on the JVM being the future premier runtime for dynamic languages.
> * Enables you to create network servers or clients incredibly easily.
> * True threading. Unlike node.js, Python Twisted or Ruby EventMachine, it has true multi-threaded scalability. No more spinning up 32 instances just to utilise the cores on your server.
> * Understands multiple protocols out of the box including: TCP, SSL, UDP, HTTP, HTTPS, Websockets, AMQP, STOMP, Redis etc
> * Provides an elegant api for composing asynchronous actions together. Glue together HTTP, AMQP, Redis or whatever in a few lines of code.

A framework a la [node.js][nodejs] (and some more) in a multithreaded environment on the JVM is an intriguing idea with a lot of potential and the examples look both simple and powerful.

This project is based on [Netty][netty], an asynchronous event-driven network application framework, that I can't stop to praise. We use it in [HornetQ][hornetq] and is a big reason why [HornetQ is so fast][specjms].

Tim is an ex-colleague from [Red Hat][redhat] and the previous lead of HornetQ. He knows his stuff about performance, concurrent and asynchronous code and I am intrigued to see where he will go with [node.x][nodex] (esp. if he adds a [Clojure][clojure] layer on top of it, functional programming is a good match for an asynchronous event framework).

[hornetq]: http://www.jboss.org/hornetq
[nodex]: https://github.com/purplefox/node.x
[specjms]: http://www.spec.org/jms2007/results/jms2007.html
[tfox]: http://tfox.org/2011/07/11/say-hello-to-node-x/
[redhat]: http://www.redhat.com/
[clojure]: http://clojure.org/
[nodejs]: http://nodejs.org
[netty]: http://www.jboss.org/netty
