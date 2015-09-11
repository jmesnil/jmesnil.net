---
layout: post
title: "Stepping Out From Personal Open Source Projects"
date: '2015-09-04 09:58:05'
category: 
tags:
- development
---

Our first child, Rapha&euml;l, is born last September and we will soon celebrate his first birthday.

This year has been the happiest of my life.
However, having a baby means that I have less free time than before,
and I want to spend this time with my family or doing personal projects I feel passionate about.

These days I feel more passionate about making photography (mostly of Rapha&euml;l and Marion) than writing software (I already
have a full time job at Red Hat where I enjoy coding on [WildFly][wildfly]).

Before our baby's birth, I could spend evenings and weekends working on personal Open Source projects.
After one year, it is time to admit that I do not want to that anymore and act accordingly.

I have decided to flag my personal Open Source projects as *not maintained anymore*.
Some of these projects are still quite used, the three main are all dealing with messaging clients:

* [stomp.js][stompjs] - a JavaScript library to write web apps/nodes.js client for STOMP protocol
* [StompKit][StompKit] - an Objective-C client for STOMP protocol
* [MQTTKit][MQTTKit] - an Objective-C client for MQTT protocol

I'll modify these projects READMEs to warn that they are no longer maintained (with a link
to that post to give some context).

It's not fair to users to spend time using them, reporting bugs and have no warning that their issues will be ignored.

If you are using these projects, I understand that you may be upset that your bugs are not fixed or that the enhancement
you request will not be fixed in the original project.
Fortunately, these projects are licensed under the Apache License V2. You can fork them (they are hosted on GitHub and use Git as their version control system) and 
modify them to suit your needs.

I also had some discussion to [donate stomp.js to Apache ActiveMQ][donation].

It is a tough decision to not maintain these projects anymore but it is a decision that I have subconsciously made months ago.
Now I just have to acknowledge it.

I may revisit this decision when my child is older or when I feel passionate about these project again. Or I may create other Open Source projects, who knows?

The key thing is that by releasing these projects under an Open Source license, I ensured that their use could outlast
my initial contributions to it.

[stompjs]: https://github.com/jmesnil/stomp-websocket
[StompKit]: https://github.com/mobile-web-messaging/StompKit
[MQTTKit]: https://github.com/mobile-web-messaging/MQTTKit
[donation]: http://activemq.2283324.n4.nabble.com/Code-donation-for-stomp-js-tp4694260.html
[wildfly]: http://wildfly.org
