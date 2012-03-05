---
date: '2010-12-08 21:54:54'
layout: post
slug: websocket-disabled-in-firefox-4
status: publish
title: ⚑ WebSocket disabled in Firefox 4
wordpress_id: '1510'
tags:
- web
---

> This is a serious threat to the Internet and Websocket and not a browser specific issue. The protocol vulnerabilities also affect Java and Flash solutions. In a web environment that could for example mean that a widely used JavaScript file – like Google analytics – could be replaced on a cache you go through with a malware file.

I think Mozilla decision makes sense and they are right to be cautious.

I am interested by Web Sockets (I implemented a JavaScript library to use [STOMP over Web Sockets][stomp-ws] for messaging) but we need to be very careful about opening a new communication channel between Web clients and servers. Web Sockets must integrate with the whole Web infrastructure (including caches and proxies) and not open a whole can of security issues.

The HTML5 Web Socket API has a lot of potental, especially now that it is available on iOS-based devices (I wrote a [node.js-based application][board-node] which uses it) but it is critical to get the protocol right before it is widespread.

Once Web Sockets are out in the wild, we will have to live with them for a long time, deal with their issues on our own and face ugly consequences for rushing it out.

[stomp-ws]: http://jmesnil.net/stomp-websocket/doc/
[board-node]: https://github.com/jmesnil/board-node
