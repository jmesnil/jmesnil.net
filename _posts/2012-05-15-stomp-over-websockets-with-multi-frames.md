---
layout: post
title: "STOMP Over WebSockets With Multiple Frames"
date: '2012-05-15 18:27:34'
---

I updated [stomp-websocket][stomp-websocket] JavaScript library to fix a critical bug.

When it receives a WebSocket *message*, I was parsing it to unmarshall a *single STOMP frame*.
However it is valid to send _many STOMP frames in a single WebSocket message_ ([ActiveMQ Apollo][apollo] does this). I updated the code to take this into account (and check for `content-length` header too).

This should considerably improve the performance when consuming STOMP messages from the Web browsers.

Thanks to [rfox90][rfox90] which proposed a solution to this fix and Jeff Robbins which tested it on many STOMP brokers to validate it.

The latest version of the library is available on [GitHub][github]. 

[apollo]: http://activemq.apache.org/apollo/
[stomp-websocket]: http://jmesnil.net/stomp-websocket/doc/
[rfox90]: https://github.com/rfox90
[github]: https://github.com/jmesnil/stomp-websocket/blob/master/dist/stomp.js
