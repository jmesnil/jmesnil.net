---
layout: post
title: "stomp.js for node.js apps"
date: '2013-09-25 17:50:49'
category: 
tags: []
---

[stomp.js][stompws] is a simple JavaScript library to send and receive [STOMP][stomp] messages from a Web browser using Web Sockets.

Today, I have released its [version 2.3.0][release] that adds support for [node.js][nodejs].
This makes it possible to send and receive STOMP message from any node.js app by connecting to a STOMP broker on its TCP port (usually 61613) _or on its Web Socket._

I have registered a npm package [stompjs][stompjs] that can be installed by typing:

    npm install stompjs

and in the code, requiring the module:

    var Stomp = require('stompjs');
    
To connect to a STOMP broker over a TCP socket, use the `Stomp.overTCP(host, port)` method:

    var client = Stomp.overTCP('localhost', 61613);

To connect to a STOMP broker over a Web Socket, use instead the `Stomp.overWS(url)` method:

    var client = Stomp.overWS('ws://localhost:61614/stomp');
    
Apart from this initialization, the STOMP API remains the same whether it is running in a Web browser or in node.js application.

A simple node.js app that sends and receives a STOMP message can be coded in a few lines:

<pre><code class='javascript'>var Stomp = require('stompjs');

// Use raw TCP sockets
var client = Stomp.overTCP('localhost', 61613);
// uncomment to print out the STOMP frames
// client.debug = console.log;

client.connect('user', 'password', function(frame) {
  console.log('connected to Stomp');

  client.subscribe('/queue/myqueue', function(message) {
    console.log("received message " + message.body);

    // once we get a message, the client disconnects
    client.disconnect();
  });
  
  console.log ('sending a message');
  client.send('/queue/myqueue', {}, 'Hello, node.js!');
});
</code></pre>

In this example, the client connect to the STOMP broker on its TCP socket by calling `Stomp.overTCP(host, port)`:

<pre><code class='javascript'>var client = Stomp.overTCP('localhost', 61613);
</code></pre>

To connect on its Web Socket, you only need to change the creation of the client by calling instead `Stomp.overWS(url)`:

<pre><code class='javascript'>var client = Stomp.overWS('ws://localhost:61614');
</code></pre>

This means that if your code uses stomp.js, you can run the  _same code_ in the Web browser or in node.js That may prove handy for testing...

Why another STOMP client for node.js when there are already [a dozen][many]?

I believe the code of stomp.js is already the best of them.

It is distributed by the major STOMP brokers ([ActiveMQ][activemq], [Apollo][apollo], [HornetQ][hornetq], and [RabbitMQ][rabbitmq]), widely used, thoroughly tested and _[documented][stompws]_.

The STOMP protocol implementation is the same whether the client is running in a Web browser or in node.js. The only differences are the timers and the socket implementations (native Web Socket for Web browser, net.Socket for node.js). The socket implementation can still be customized and many users run it over [SockJS][sockjs]

There are likely some corner cases to iron out but the main features (including heart-beating) should work as expected.

Note that the node.js support is done outside the [stomp.js][stompjsfile] file.
If you only need to use STOMP from the Web browser, this changes nothing: you only need that file (or its [minified version][minified]).

Enjoy!

[stompws]: http://jmesnil.net/stomp-websocket/doc/
[stomp]: http://stomp.github.io
[release]: https://github.com/jmesnil/stomp-websocket/releases/tag/v2.3.0
[nodejs]: http://nodejs.org
[stompjs]: https://npmjs.org/package/stompjs
[many]: https://npmjs.org/search?q=STOMP
[rabbitmq]: http://www.rabbitmq.com/
[hornetq]: http://hornetq.org/
[activemq]: http://activemq.apache.org/
[apollo]: http://activemq.apache.org/apollo/
[sockjs]: https://github.com/sockjs/sockjs-client
[stompjsfile]: https://github.com/jmesnil/stomp-websocket/releases/download/v2.3.0/stomp.js
[minified]: https://github.com/jmesnil/stomp-websocket/releases/download/v2.3.0/stomp.min.js