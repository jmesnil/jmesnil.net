---
date: '2010-04-29 10:47:15'
layout: post
slug: web-sockets-support-for-hornetq
status: publish
title: Web Sockets Support for HornetQ
wordpress_id: '1062'
tags:
- misc
---

Exchanging messages directly between a Web browser and a messaging server is an interesting use case. There are many ways to do this (AJAX, Comet, etc.). The most recent way is to use [Web Sockets][ws].

### What are Web Sockets? ###

Web Sockets are "TCP for the Web". A Web Socket is a bi-directional communication between a browser and a server that follows the HTTP same-origin model (you can only connect to a server on the same origin than the HTTP request that served the page).

Web Sockets support has been checked in HornetQ Subversion repository.
Since Web Sockets are like TCP sockets, we needed to add a protocol on top of it with messaging semantic. A perfect candidate for this was [Stomp][stomp], a text-base messaging protocol.  
I have created a JavaScript library, [stomp-websocket][stomp-websocket], which makes it very simple to send and receive Stomp messages over Web Sockets. 

This library is not bound to HornetQ implementation. [Dejan Bosanac][dejan], from [Apache ActiveMQ][activemq], also added [Web Sockets support to ActiveMQ][activemq-ws]. A browser can use the `stomp-webscoket` library to exchange messages with either HornetQ or ActiveMQ.

### Example ###

How do you send a message from the browser to a Stomp broker? The steps are always the same:

1. create a `Stomp.client` with the broker endpoint URL
2. connect to the broker with user credentials
3. register a callback to be notified when the client is connected and authenticated
4. send a message to the broker on a given destination

<pre><code class='javascript'>var client = Stomp.client("ws://blackbook.local:61614/stomp");
client.connect("guest", "guest", function() {
   // called back after the client is connected and authenticated to the Stomp server
   client.send("/queue/test", {priority: 9}, "Hello, from the browser");
});
</code></pre>

Receiving messages from the broker involves an additional step where the client subscribes to a destination:

<pre><code class='javascript'>client.subscribe("/queue/test", function(message)
{
  // called back every time the client receives a message from the broker for the destination
  $("#messages").append("&lt;p>" + message.body + "&lt;/p>\n");
};
</code></pre>

[`stomp-websocket` documentation][stomp-websocket] explains in more details how to use the library. The project is hosted on [GitHub][github] and ships with a chat example where browser clients sends and receives messages from a topic.


### HornetQ Implementation ###

Web Socket and Stomp support in HornetQ are quite new and a bit rough around the edges (e.g. no implicit mapping between Stomp message and JMS messages, destinations mapping to addresses and queues). Do not hesitate to report issues in [HornetQ bug tracker][hornetq-jira] and contribute patches.

To accept Web Sockets connection from port `61614`, add a `<acceptor>` to `hornetq-configuration.xml`:

    <acceptor name="stomp-ws-acceptor">
       <factory-class>org.hornetq.core.remoting.impl.netty.NettyAcceptorFactory</factory-class>
       <param value="stomp_ws" key="protocol"></param>
       <param value="61614" key="port"></param>
    </acceptor>

Web Sockets can then connect to `ws://localhost:61614/stomp` endpoint.

### Web Sockets Status ###

Web Sockets is a recent Web technology and few browsers support it (only [WebKit][webkit] nightly builds and [Google Chrome][chrome] at the moment).
The protocol is a moving target (at the time of this writing, the handshake specification is changing significantely) and applications using Web Sockets may break until browsers and servers agree on the protocol.

Besides, the specification status is a bit unclear. The protocol is at the [IETF][ietf] but the revised draft is at [WHATWG][whatwg], while the browser API is at [W3C][w3c]. Mozilla is [cautious (with reasons)][firefox] to add it to Firefox and I have not seen any indication that Internet Explorer will support it.  
It is likely that its use on the desktop will not be widespread soon. However it may really shine on _mobile platforms_.

Both the iPhone and Android Web browsers are based on WebKit. Future releases of the platforms will likely add
support for Web Sockets (but I did not find any roadmap for it...).
 With Web Sockets, browsers on Android, iPhone, iPad will be able to send and receive messages in a simple and efficient fashion. Combining that with [offline support][offline], Web developers have great tools to build Web applications.

I am looking forward to seeing what they will come up with!


 
[ws]: http://dev.w3.org/html5/websockets/
[netty]: http://jboss.org/netty
[hornetq]: http://jboss.org/hornetq/
[stomp-websocket]: http://jmesnil.net/stomp-websocket/doc
[activemq]: http://activemq.apache.org/
[activemq-ws]: http://www.nighttale.net/activemq/activemq-54-stomp-over-web-sockets.html
[dejan]: http://www.nighttale.net/
[stomp]: http://activemq.apache.org/stomp/stomp10/specification.html 
[ws-blog]: http://blog.new-bamboo.co.uk/2010/2/10/json-event-based-convention-websockets
[firefox]: http://hacks.mozilla.org/2010/04/websockets-in-firefox/
[hornetq-jira]: https://jira.jboss.org/jira/browse/HORNETQ
[github]: http://github.com/jmesnil/stomp-websocket
[webkit]: http://webkit.org/
[chrome]: http://www.google.com/chrome
[w3c]: http://dev.w3.org/html5/websockets/
[ietf]: http://tools.ietf.org/html/draft-hixie-thewebsocketprotocol-75
[whatwg]: http://www.whatwg.org/specs/web-socket-protocol/
[offline]: http://diveintohtml5.org/offline.html

