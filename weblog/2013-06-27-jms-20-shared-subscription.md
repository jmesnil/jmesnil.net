---
layout: post
title: "JMS 2.0: Shared Subscription"
date: '2013-06-27 17:14:26'
category: 
tags:
- jms
---

JMS 2.0 has been released a few weeks ago. We are working hard to support it in [HornetQ][hornetq] and [WildFly](http://wildfly.org) and I plan to write a few articles about it.

The main features are described on Oracle Web site in [What's New in JMS 2.0, Part One: Ease of Use][new-part-one] and [Part Two: New Messaging Features][new-part-two].

One of the most important new features is *Shared Subscription*.

Let's assume you are using a topic to send messages. There are several components subscribed to this topic that are processing the messages in different fashion (for example to process jobs A and B).

When a message `M` is sent to the topic, all consumers subscribed to the topic receive it:

<pre><code class="no-highlight">                                   M   +--------------+
                                  ---> | consumer CA1 |  < a consumer for the job A >
    +----------+  M   +-------+ /      +--------------+
    | producer | ---> | topic |   
    +----------+      +-------+ \  M   +--------------+
                                  ---> | consumer CB1 | < a consumer for the job B >
                                       +--------------+
</code></pre>

The consumer CB1 is subscribed to the topic. Every time, it receives a message, it processes the job B.

Unfortunately, this job is time-consuming and we would like to scale it out by having several consumers for the job B running on different machines.

We can *not* have several consumers on the topic for this job, otherwise they would all receive copies of the same message and process it several times. What we need is a *set* of consumers that receives a single message from the topic amongst them.

If the component is running inside a Java EE application server, you can use a Message-Drive Bean for that. If the component is a Java SE application, you are out of luck.

Before JMS 2.0, each messaging brokers has different ways to provide this feature.

With [HornetQ][hornetq], the workaround is to use a [divert][divert]:

> Diverts allow you to transparently divert messages routed to one address to some other address, without making any changes to any client application logic.

We use a divert to *route* the messages sent to the topic to another *queue* (let's called it `Queue_B` since it's for the processing job B). Everytime a message is sent to the topic, a copy is also routed to the queue. Our divert is *non-exclusive* since we want it to still be received by the topic consumers.

We can then create as many consumers we want for `Queue_B`. Since this destination is a queue, only one of them will receive a message that was initially sent to the topic:

<pre><code class="no-highlight">                                   M   +--------------+
                                  ---> | consumer CA1 |
    +----------+  M   +-------+ /      +--------------+
    | producer | ---> | topic |  
    +----------+      +-------+  
                          \                        +--------------+
                           \ M                ---> | consumer CB1 |
                     divert \               /      +--------------+
                             \ +---------+ /       +--------------+  
                               | Queue_B | -- ---> | consumer CB2 |
                               +---------+ \       +--------------+
                                            \  M   +--------------+
                                              ---> | consumer CB3 |
                                                   +--------------+
</code></pre>                                                  

Among CB1, CB2 and CB3, only CB3 received the message sent to the topic.

There are still many shortcomings of using diverts (or similar features) to share consumers of a topic.

* for each set of shared consumers, a system administrator must create and administrate on the server one more divert and one more queue.
* the shared consumers are no longer consuming from the original topic but from a specific queue. That makes the messaging topology more complex to setup and configure in the client applications.
* the management of the messaging system becomes also more complex: there is no way to know how many subscribers are "really" listening to the topic, this information is lost when messages are routed by the divert.

Enter JMS 2.0 and its "shared subscription".

> A non-durable shared subscription is used by a client which needs to be able to share the work of receiving messages from a topic subscription amongst multiple consumers. A non-durable shared subscription may therefore have more than one consumer. Each message from the subscription will be delivered to only one of the consumers on that subscription.

The basic idea behing sharing a subscription is to have a set of consumers (identified by a shared subscription name) receiving *exclusively* a message from a topic.

That solves all the issues we originally had in a standard fashion.
We can now create many shared consumers with the shared subscription name `<< sub B >>` to have them process messages for the job B and scale out nicely:

<pre><code class="no-highlight">                                            M         +--------------+
                                    ----------------> | consumer CA1 |
                                  /                   +--------------+
                                 /                    +--------------+
    +----------+  M   +-------+ /                ---> | consumer CB1 |
    | producer | ---> | topic |                /      +--------------+
    +----------+      +-------+ \             /   M   +--------------+
                                  << sub B >> -- ---> | consumer CB2 |
                                              \       +--------------+
                                               \      +--------------+
                                                 ---> | consumer CB3 |
                                                      +--------------+
</code></pre>

Among the shared consumers CB1, CB2 and CB3, only CB2 received the message sent to the topic.

* all our consumers are directly consuming from the topic
* there are no additional resources to configure or administrate on the server

The JMS 2.0 API adds new methods to [create *shared consumer*][javadoc]:

<pre><code class="java">    JMSContext.createSharedConsumer(Topic topic, String sharedSubscriptionName)
    JMSContext.createSharedConsumer(Topic topic, String sharedSubscriptionName, String messageSelector)
</code></pre>

It is also possible to create *shared durable consumers*:

<pre><code class="java">    JMSContext.createSharedDurableConsumer(Topic topic, String name)
    JMSContext.createSharedDurableConsumer(Topic topic, String name, String messageSelector)
</code></pre>

Sharability and durability of subscriptions are two orthogonal notions and all the combination are possible:

* a *unshared non-durable* subscription can only have one consumer that will not receive messages sent while its consumer was offline
* a *unshared durable* subscription can only have one consumer that will receive the messages sent while its consumer was offline
* a *shared non-durable* subscription can have many consumers that will not receive messages sent while all consumers were offline.
* a *shared durable* subscription can have many consumers that will not receive the messages sent while all consumers were offline.

JMS 2.0 is an incremental update to JMS that should simplify any Java application using messages. Shared subscription is one of this interesting new features.

[new-part-one]: http://www.oracle.com/technetwork/articles/java/jms20-1947669.html
[new-part-two]: http://www.oracle.com/technetwork/articles/java/jms2messaging-1954190.html
[hornetq]: http://hornetq.org/
[divert]: http://docs.jboss.org/hornetq/2.3.0.Final/docs/user-manual/html/diverts.html
[javadoc]: https://jms-spec.java.net/2.0/apidocs/javax/jms/JMSContext.html#createSharedConsumer(javax.jms.Topic,%20java.lang.String)