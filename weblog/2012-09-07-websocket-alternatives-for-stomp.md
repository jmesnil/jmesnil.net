---
layout: post
title: "WebSocket alternatives for STOMP"
date: '2012-09-07 16:17:44'
category: 
tags: []
---

I wrote previously about a hack to use [SockJS with Stomp over WebSockets][previous]:

<pre><code class='javascript'>Stomp.WebSocketClass = SockJS;
// same as usual
var client = Stomp.client(url);
[...]
</code></pre>

However, this was ugly and of limited use: the instantiation of the Web Socket was still done inside <code>Stomp.client()</code> function.

[Marek Majkowski][majek] then proposed to update the library to be able to pass any object conforming to the WebSocket type to enable [all kind of cool stuff][rabbitmq].

I have updated the library to use STOMP over any kind of WebSocket objects:

<pre><code class='javascript'>var ws = new SockJS(url);
var client = Stomp.over(ws);
// the rest of the code is the same
[...]
</code></pre>

As written in the [documentation][alt], you can use `Stomp.client(url)` to let the library create regular WebSockets or use `Stomp.over(ws)` if you required another type of WebSocket.

Web Sockets for everyone!

[previous]: /weblog/2012/06/05/using-sockjs-with-stomp-over-web-sockets/
[alt]: /stomp-websocket/doc/#alternative
[majek]: https://github.com/majek
[rabbitmq]: https://www.rabbitmq.com/blog/2012/02/23/how-to-compose-apps-using-websockets/