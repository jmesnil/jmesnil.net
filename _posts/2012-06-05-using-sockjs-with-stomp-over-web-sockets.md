---
layout: post
title: "Using SockJS with Stomp Over Web Sockets"
date: '2012-06-05 10:06:20'
---

Recently RabbitMQ announced that is was [exposing STOMP through Web Sockets][rabbitmq] and showed an example using my [stomp-websocket][stomp-ws] JavaScript library.

They leveraged a hack in the library to replace the Web browser `WebSocket` implementation by the one provided by the [SockJS][sockjs] library which falls back to a variety of browser-specific transport protocols if the browser does not suppor the Web Socket protocol.

Originally introduced to test the `stomp-websocket` library, it defined a `WebSocketStompMock` global variable that was replacing the Web browser `WebSocket` class by a mock. This was not meant to be used on the client side and is a bit dirty for that (as it pollutes the global namespace).

An user [reported][issue] that this hack was no longer working on recent commits.

I fixed it and introduced a cleaner way to switch the WebSocket implementation to use by setting the `Stomp.WebSocketClass` variable instead.

With the most recent version, Web browsers can now leverage the SockJS libary with stomp-websocket using the following code:
{% highlight js %}
    Stomp.WebSocketClass = SockJS;
    // same as usual
    var client = Stomp.client(url)
    [...]
{% endhighlight %}

Web Sockets for everyone!

[rabbitmq]: http://www.rabbitmq.com/blog/2012/05/14/introducing-rabbitmq-web-stomp/
[sockjs]: https://github.com/sockjs/sockjs-client
[issue]: https://github.com/jmesnil/stomp-websocket/issues/11
[stomp-ws]: https://github.com/jmesnil/stomp-websocket

