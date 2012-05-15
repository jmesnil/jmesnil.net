---
layout: post
title: "RabbitMQ + STOMP + WebSockets"
date: '2012-05-15 18:06:13'
link: http://www.rabbitmq.com/blog/2012/05/14/introducing-rabbitmq-web-stomp/
---

RabbitMQ is now providing messages to Web browsers with STOMP over Web Sockets.

Interestingly, in their examples, they use my [stomp-websocket library][stomp-websocket] library with [SockJS][sockjs] instead of the native `WebSocket` object:

{% highlight js %}
WebSocketStompMock = SockJS;

var client = Stomp.client('http://127.0.0.1:55674/stomp');
...
{% endhighlight %}

[stomp-websocket]: http://www.jmesnil.net/stomp-websocket/doc/
[sockjs]: https://github.com/sockjs/sockjs-client
