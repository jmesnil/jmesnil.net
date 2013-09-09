---
layout: post
title: "Writing a Book for O'reilly about Mobile & Web Messaging"
date: '2013-09-09 13:39:35'
category: 
tags:
- book
---

The title says it all: I've agreed with [O'Reilly Media][oreilly] to write a book about _Mobile and Web Messaging_.

Almost all my career has been spent developing messaging platforms or clients using messaging.
The last few years, I have focused on messaging for Mobile and Web platforms.

* I added [STOMP][stomp] support to [HornetQ][hornetq] to be able to send and receive messages from iOS and Android apps.
* I wrote [stomp.js][stompjs] to send and receive messages from HTML5 Web Browsers<a id="fnr1-2013-09-09" href="#fn1-2013-09-09"><sup>1</sup></a>. This small library is now used by the main Open Source messaging brokers ([ActiveMQ][activemq], [Apollo][apollo], [RabbitMQ][rabbitmq] in addition to HornetQ).

This book is the result of all this work and will help mobile and Web developers leverage messaging protocols in their applications.

I plan to introduce messaging protocols and write about STOMP (and most likely [MQTT][mqtt] too) in details. The book will come with examples for mobile platforms and Web browsers.

I have setup a web site at [mobile-web-messaging.net][mwm] to promote the book and will tweet about it at [@mobilewebmsg][mobilewebmsg].

The target release for the book is June 2014.

For a long time, I wanted to write a technical book and it is a chance to do it about an interesting subject and be published by the best editor for programming books. O'Reilly agreed to publish the book under an Open Source license and the source and examples will be hosted on [GitHub][github] (when I have some material to show).

This opportunity is only possible because my employer, [Red Hat][redhat], allows me to spend some of my work time on this book. Red Hat is an awesome company to work for and we are [hiring][jobs]!

I am incredibly excited about this book and look forward to sharing some sample chapters. I just need to start writing them now! :)

---

1. <a id="fn1-2013-09-09"></a> That's why I just [released a new version][release] of stomp.js. I plan to write a chapter about it and found some shortcomings that I wanted to fix.&nbsp;<a href="#fnr1-2013-09-09">&#8617;</a>


[mobilewebmsg]:https://twitter.com/mobilewebmsg
[oreilly]: http://oreilly.com
[redhat]: http://www.redhat.com
[jobs]: http://jobs.redhat.com
[mwm]: http://mobile-web-messaging.net
[stomp]: http://stomp.github.io
[mqtt]: http://mqtt.org
[hornetq]: http://www.jboss.org/hornetq/
[stompjs]: http://jmesnil.net/stomp-websocket/doc/
[activemq]: http://activemq.apache.org
[apollo]: http://activemq.apache.org/apollo/index.html
[rabbitmq]: http://www.rabbitmq.com/
[release]: /weblog/2013/09/03/stompjs-210-is-released/
[github]: https://github.com/mobile-web-messaging/book/