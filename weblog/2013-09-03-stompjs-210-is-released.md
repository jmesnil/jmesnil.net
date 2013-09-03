---
layout: post
title: "stomp.js 2.1.0 is Released"
date: '2013-09-03 17:29:21'
category: 
tags: []
---

I have released a new version of [Stomp over WebSockets](http://jmesnil.net/stomp-websocket/doc/).

During my summer holidays, I have simplified its API to make it more _object-oriented_ instead of a simple translation of the protocol frames. The new API is backwards compatible _except for the susbcription change_.

The [documentation](http://jmesnil.net/stomp-websocket/doc/) has been updated to reflect the new API.

I also created a [2.1.0 release](https://github.com/jmesnil/stomp-websocket/releases/tag/v2.1.0) on GitHub to provide a well-known location to download [stomp.js](https://github.com/jmesnil/stomp-websocket/releases/download/v2.1.0/stomp.js) (and its [minified version](https://github.com/jmesnil/stomp-websocket/releases/download/v2.1.0/stomp.min.js)).

## Connection

The `connect()` method accepts different number of arguments to provide a simple API to use in most cases:

<pre><code class='javascript'>client.connect(login, passcode, connectCallback);
client.connect(login, passcode, connectCallback, errorCallback);
client.connect(login, passcode, connectCallback, errorCallback, host);
</code></pre>

where `login`, `passcode` are strings and `connectCallback` and `errorCallback` are functions (some brokers also require to pass a [host](http://stomp.github.io/stomp-specification-1.1.html#CONNECT_or_STOMP_Frame) String).

The `connect()` method also accepts two other variants if you need to pass additional headers:

<pre><code class='javascript'>client.connect(headers, connectCallback);
client.connect(headers, connectCallback, errorCallback);
</code></pre>

where `header` is a map and `connectCallback` and `errorCallback` are functions.

Please note that if you use these forms, you __must__ add the `login`, `passcode` (and eventually `host`)  headers yourself:

<pre><code class='javascript'>var headers = {
  login: 'mylogin',
  passcode: 'mypasscode',
  // additional header
  'client-id': 'my-client-id'
};
client.connect(headers, connectCallback);
</code></pre>
## Acknowledgement

The message objects passed to the `subscribe` callback now have `ack()` and `nack()` methods 
to directly acknowledge (or not) the message.

<pre><code class='javascript'>var sub = client.subscribe("/queue/test",
  function(message) {
    // do something with the message
    ...
    // and acknowledge it
    message.ack();
  },
  {ack: 'client'}
);
</code></pre>

## Unsubscription

Instead of returning an id from `client.subscribe()`, `subscribe()` returns
an object with an `id` property corresponding to the subscription ID and an `unsubscribe()` method.

<pre><code class='javascript'>var subscription = client.subscribe(...);
...
subscription.unsubscribe();
</code></pre>

## Transaction

The `begin()` method returns a JavaScript object with `commit()` and
`abort()` methods to complete the transaction.

<pre><code class='javascript'>var tx = client.begin();
message.ack({ transaction: tx.id, receipt: 'my-receipt' });
...
tx.commit(); // or tx.abort();
</code></pre>

A transaction ID is automatically generated when calling `'begin()` and is available in the returned object's `id` property.

## Miscellaneous changes and fixes

* default onreceive method

  When a subscription is automatically created on the broker-side, the received messages are discarded by the Stomp.client that find no matching callback for the subscription headers.
  To workaround that, the client can set a default `onreceive` callback that will be called if no matching subscription is found.

  This is required to support [RabbitMQ temporary queue destinations](http://www.rabbitmq.com/stomp.html#d.tqd).

* By default, debug messages are now written in `window.console`.

* STOMP can now be used from a _WebWorker_ (an example shows how to use it).

* STOMP frame fragmentation

  If the STOMP frames are big to send on a single WebSocket frame, some web server may have trouble process them. It is now possible to split a STOMP frame on multiple Web Socket frames by configuring the `client.maxWebSocketFrameSize` (in bytes). If the STOMP frame is bigger than this size, it will be send over multiple Web Socket frames (default is `16KiB`).

* use the 1st value for repeated headers

  Stomp.js was keeping the last value of [repeated headers](http://stomp.github.io/stomp-specification-1.2.html#Repeated_Header_Entrie). This has been fixed according to the specification to take the __1st__ value of repeated headers.

* fix generation of timestamp on IE8
