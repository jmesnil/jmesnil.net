---
date: '2006-08-18 20:56:43'
layout: post
slug: replication-of-mbeans-on-a-cluster
status: publish
title: Replication of JMX MBeans on a Cluster
wordpress_id: '140'
tags:
- java
- jmx
---

This a long post about designing JMX management on a cluster.  
To make a long story short: is it a good idea to replicate MBeans on a cluster
of Java applications?

I'm working on a Java application which consists of a cluster of nodes, each node 
running in a separate JVM.  
Nodes communicates through a common channel through a group communication protocol.  
Nodes are mostly independent but they are notified when a node joins or leaves 
the group communication channel.

Each node exposes its managements operations through JMX and contains its own JMX Server which exposes the MBeans of the nodes  
An administrator can manage each MBeans of the node through JMX using either a RMI or HTTP adaptor:

[![jmx-1](http://static.flickr.com/82/218541952_36f9f32f7a.jpg)](http://www.flickr.com/photos/jmesnil/218541952/)


But the issue is that the cluster does not provide global management.
For example, if an administrator wants to manage two MBeans on different nodes to the cluster, he /she has to:

1. connect to the JMX server of the 1st node
2. invoke the management operations on a MBean
3. connect to the JMX server of a 2nd node
4. invoke the management operations on another MBean

Not very user-friendly...

There are even worse use cases: some management operations should not be
performed depending on the state of resources on the other nodes of the cluster.

For example, imagine in the picture above that the MBeans X, Y, Z and T represent
the same kind of resource: a `Light` which can be turned on or off.  
A mandatory requirements on the cluster is tha there must be always at least one 
light which is turned on in the cluster at any time.

If the administrator wants to close the light represented by MBean X, he/she
has to be sure first that either lights Y, Z or T are still on.
Bad news: the management operation is depending on the good will of the admin...

Of course, for our application, we can code a JMX client which does all the grunt work
for the admin but putting the management workflow in the JMX client is a *bad* idea:
we open the MBeans to the world and it's likely that some administrators will
prefer use a graphical JMX console or a Web one. In that case, they would bypass
parts of the management workflow... 

In an ideal world, the admin should only ask the light X to switched off and it's
up to the cluster to check if it's possible or not.

Of course, we could use the group communication channel to communicate between
the nodes of the cluster but I'm not seduced by this proposal. I'd like to keep
the management logic as much separate as possible from the business logic which
already uses the group channel to exchange data.

Another point: the cluster does not have a central repository to get information
or state about the cluster. So it may be interesting to replicate this information
on all nodes of the cluster so that whatever node the admin is connected to (through
its JMX server), he/she can see the global state of the cluster and perform management
operations on any of its nodes.

How do I plan to do that?
I was thinking about registering on each node *proxies* of MBeans whose *real implementations*  are hosted
on other nodes:

[![jmx-2](http://static.flickr.com/75/218536945_64e32eefb4.jpg)](http://www.flickr.com/photos/jmesnil/218536945/)

The dashed rhombus are Mbeans *proxies* while the plain ones are the *real implementations*.

In the picture above, when the node #2 joins the cluster, I create proxies of the
MBeans registered on existing member of the cluster, node #1 (he received enough information
to connect to their JMX servers when joining the group). I register in
the JMX server of node #2 the proxies of MBean X and Y with __the same ObjectName
than the *real* Mbeans__ (which are on node #1).  
Since node #1 is also notified that a new node has joined the cluster, he also creates proxies
of MBean Z and T and register them on its own JMX server (still using the same ObjectName than
the real ones).

If I go that way, management operations are simplified.
To continue on the lights example, the sequence is now:

1. the admin connect to the JMX server of node #1
2. it invokes the `off()` operation on Mbean X
3. the implementation of MBean X will query the JMX Server of node #1 about all the Light Mbeans and checks there is still one which is on (excluding itself)
4. when it checks on MBean Z, the proxy will connect to the JMX server of node #2 and invokes the method on the real implementation of MBean Z

[![jmx-3](http://static.flickr.com/67/218536946_ee36036b17.jpg)](http://www.flickr.com/photos/jmesnil/218536946/)

* (1) from the client, connect to the JMX Server of node #1
* (2) get the MBean X and invoke one of its method
* (3) get the MBean Z and invoke one of its method
   * (3') the *proxy* of MBean Z will connect to the JMX Server of node #2
   * (3'') the *real implementation* of  MBean Z method will be invoked 

The cool thing about this design is that the admin does not even need to be connected to the JMX Server of node #1 to manage MBean X:

[![jmx-4](http://static.flickr.com/88/218536947_65135005cb.jpg)](http://www.flickr.com/photos/jmesnil/218536947/)

* (1) from the client, connect to the JMX Server of node #2
* (2) get the MBean X and invoke one of its method
   * (2') the *proxy* of MBean X will connect to the JMX Server of node #1
   * (2'') the *real implementation* of MBean X method will be invoked
* (3) get the MBean Z and invoke one of its method

The code is the same regardless of the node the administrator is connected (since the *proxies* and the *real implementations*
share the same `ObjectName` on all the JMX Servers of the nodes of the cluster).  
And the whole design is quite dynamic since each JMX Server can also be notified when MBeans are registered or unregistered on other JMX Servers of the cluster

However I already see some issues with that approach:

* what about security credentials when forwarding an invokation from one JMX Server to another?
* what about the scalablity if the number of nodes or MBeans increases?
* what about event notifications? I'm interested to be notified of events emitted by the *real* MBeans, not the proxies. How do I make the difference when registering `NotificationListener` based only on the `ObjectNames` wich are identical?
* and the first question I asked you at the beginning of this post: is it a good idea to replicate MBeans on a cluster
of Java applications?

Are theses issues showstoppers either architecturally or technically?

I did some searches on the web about this kind of approach with regards to JMX but
I did not find anything conclusive so far so I plan to code a prototype to handle this stuff and see where it leads me.
[Update: [Coherence](http://wiki.tangosol.com/display/COH32UG/Managing+Coherence+using+JMX) seems to provide this feature.] 

Wow! Still with me after this long post? In that case, I'd be happy to talk about this design with you.
Please do not hesitate to post a comment or [send me a mail](mailto:jmesnil@gmail.com).
