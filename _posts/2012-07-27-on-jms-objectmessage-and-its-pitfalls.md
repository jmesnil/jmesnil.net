---
layout: post
title: "On JMS ObjectMessage And Its Pitfalls"
date: '2012-07-27 10:02:50'
category: 
tags:
 - java
---

I have been working on head scratching issues related to [JMS ObjectMessage][objectmessage] all week, ranting about it aloud, on IRC, in JIRA comments... Let's try to be constructive and address exactly why ObjectMessage is a bad idea and what should be used instead.

From [JMS Message javadoc][message]:

> The JMS API defines five types of message body:
> 
> __Stream__ - A StreamMessage object's message body contains a stream of primitive values in the Java programming language ("Java primitives"). It is filled and read sequentially.  
> __Map__ - A MapMessage object's message body contains a set of name-value pairs, where names are String objects, and values are Java primitives. The entries can be accessed sequentially or randomly by name. The order of the entries is undefined.  
> __Text__ - A TextMessage object's message body contains a java.lang.String object. This message type can be used to transport plain-text messages, and XML messages.  
> __Object__ - An ObjectMessage object's message body contains a Serializable Java object.  
> __Bytes__ - A BytesMessage object's message body contains a stream of uninterpreted bytes. This message type is for literally encoding a body to match an existing message format. In many cases, it is possible to use one of the other body types, which are easier to use. Although the JMS API allows the use of message properties with byte messages, they are typically not used, since the inclusion of properties may affect the format.

Of those five, only two are useful: Bytes and Text messages. The three others have their own issues<a id="fnr1-2012-07-27" href="#fn1-2012-07-27"><sup>1</sup></a> but today's rant is about ObjectMessage.

Before analyzing ObjectMessage issues, let's see how it is used.

A Java client creates a `ObjectMessage` and set its body to a `Serializable` object (let's call it _`payload`_). It then sends it to a JMS `Destination`. The payload is sent over the wire as a stream of bytes. Note that the JMS API does not mandate *how* the payload can be serialized (it can be with standard Java serialization or something else).

Other Java clients (one if the destination is a queue, many if it is a topic) will receive this message with the serialized payload. They will call `ObjectMessage.getObject()` to retrieve the `payload` Java object. It is the responsibility of the messaging provider to deserialize the stream of bytes and reconstruct the `payload` object before passing it to the client.

Simple, isn't it? Not really.

# Architectural Issues

One of the advantage of using messaging system is _loose coupling_. The producers and consumers of a destination does not need to know each other or be online at the same time to exchange messages. They only need to agree on the data sent in the message.

By using an `ObjectMessage`, the type of the Java object is their agreement. This means that both sides MUST be able to understand the object and its whole graph type. You are losing one degree of abstraction by using an ObjectMessage, the consumer(s) of this message must know the implementation type of the payload and have all the classes required to deserialize it. This introduces a strong coupling between producers and consumers since they now must share a common set of classes (which grows with the complexity of the payload type).

There is a simple solution to reduce this issue (but not removing it entirely):  **use [DTO][dto] for ObjectMessage payload**

# Technical Issues

The technical issues of using ObjectMessage are related to the deserialization of the stream of bytes sent over the wire.
To be able to deserialize an object, the messaging provider must be able to recreate the instance *as it was when it was serialized*. This also implies that we must have access to the same classes and classloader that were used to serialize the payload. My colleague, Jason Greene, has a nice article about [modular serialization][modular-serialization]. Unfortunately, this is something more complex in our case since it is possible (and often the case!) that consumers of messages run in different environments than the producer.

As an example, we can have:

1. a Servlet that sends a message to a topic (its environment is a _Java EE WAR module_) 
2. a MDB that consumes it (its environment is a _Java EE EJB module_) 
3. a standalone Java application that also consumes it (its environment is a _regular Java application_)

Clients (1) and (2) will run in a modular application (e.g. JBoss AS7) while client (3) will run in a non-modular application (using regular Java classpath).

How can client (3) be expected to deserialize a class that was serialized in a different environment?
Conversely if the client (1) use standard Java serialization, how can the client (2) be expected to deserialize it if it is not able to load all classes in the payload type (as modules does not export their dependencies)?

There is a simple solution to remove this issue: 

1. **Do not use ObjectMessage** 
2. **Instead, define a data structure for the payload (using XML, JSON, protobuf, etc.) and use Text or Bytes message**

# Performance issues

How much space does it take to store a Java class with int and String fields as bytes instead of storing directly the int and the String?

[3.7 times more][gist]<a id="fnr2-2012-07-27" href="#fn2-2012-07-27"><sup>2</sup></a>

It is not as simple to compare the size of a serialized Java object with the corresponding XML, JSON, protobuf payload.
All these bytes are transported on the wire. The more bytes to serialize/transport/deserialize, the slower the message is delivered. (even though _premature optimization is the root of all evil_ still prevails).

# Conclusion

At first glance, ObjectMessage looks like a good idea. It lets application remains comfortable in dealing only with Java objects. But it opens a whole can of architectural, technical and performance issues that will need to be dealt with a moment or another (probably after the application is put in production...)

I would suggest to reduce as much as possible the use of ObjectMessage (with the goal of getting rid of them completely) with a 2 steps:

1. **Use [DTO][dto] for ObjectMessage payload**
2. **If possible, define a data representation for the payload (JSON, protobuf, XML) and use Text or Bytes message to carry it**

It is not a huge task and your application will be all the better for it (loose-coupled, resilient to changes, explicit payload agreement, etc.)

---

1. <a id="fn1-2012-07-27"></a> For example, what if messages can also produced and consumed from non-Java applications using [STOMP][stomp] protocol?&nbsp;<a href="#fnr1-2012-07-27">&#8617;</a>
2. <a id="fn2-2012-07-27"></a> Meaningless numbers, so sue me...&nbsp;<a href="#fnr2-2012-07-27">&#8617;</a>

[dto]: http://en.wikipedia.org/wiki/Data_transfer_object
[message]: http://docs.oracle.com/javaee/6/api/javax/jms/Message.html
[objectmessage]: http://docs.oracle.com/javaee/6/api/javax/jms/ObjectMessage.html
[modular-serialization]: https://community.jboss.org/wiki/ModularSerialization
[gist]: https://gist.github.com/3187135
[stomp]: http://stomp.github.com/