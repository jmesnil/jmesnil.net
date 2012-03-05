---
date: '2010-01-14 15:24:49'
layout: post
slug: using-stomp-with-hornetq
status: publish
title: '⚑ Using Stomp with HornetQ '
wordpress_id: '878'
tags:
- redhat
---

[![](http://www.jboss.org/files/jbosslabs/design/hornetQ/logo/images/hornetQ_icon_64x64.png)](http://jboss.org/hornetq/)

My daily job at [Red Hat][rh] is to work on [HornetQ][hornetq].

As the home page says:
> HornetQ is an open source project to build a multi-protocol, embeddable, very high performance, clustered, asynchronous messaging system

Yesterday, we released HornetQ 2.0.0 which supports 2 messaging APIs, [JMS][jms] and HornetQ's own [Core messaging API][core-api].  
However, we already have users who wants to use HornetQ in non-Java environments.

One solution is to use [Stomp][stomp] with HornetQ so that any [Stomp clients][stomp-clients] can communicate with HornetQ.

To show how to setup HornetQ and Stomp together, I created a [project][hornetq-stomp] with the source code and all the required jars on GitHub:

    git clone git://github.com/jmesnil/hornetq-stomp.git

The source code consists in a single class which configures and starts a fully functional standalone HornetQ server
and connects it to Stomp:


    
    
    public class HornetQStompServer {
       public static void main(String[] args) throws Exception {
    
          Configuration configuration = new ConfigurationImpl();
          // to keep things simple, we disable security. In real use, we'd setup authentication properly
          configuration.setSecurityEnabled(false);
          // we add a In-VM acceptor to HornetQ as the server will be accessible outside using Stomp
          configuration.getAcceptorConfigurations().add(
             new TransportConfiguration(InVMAcceptorFactory.class.getName()));
          // we add a Queue which will be available to Stomp under /queue/a
          configuration.getQueueConfigurations().add(
             new QueueConfiguration("jms.queue.a", "jms.queue.a",null, true));
    		
          // we create the HornetQ server using this config
          HornetQServer hornetqServer = HornetQServers.newHornetQServer(configuration);
          // we also create a JMS server manager as Stomp is using the JMS API
          JMSServerManager jmsServer = new JMSServerManagerImpl(hornetqServer);
          // starting the JMS server will also start theHornetQ server underneath
          jmsServer.start();
    
          // We create directly a JMS ConnectionFactory which will be 
          // connected to the HornetQ server using In-VM connection
          ConnectionFactory connectionFactory = HornetQJMSClient.createConnectionFactory(
             new TransportConfiguration(InVMConnectorFactory.class.getName()));
    
          // We inject the connection factory in Stomp
          StompConnect stompConnect = new StompConnect(connectionFactory);
          // and start it using default Stomp config
          stompConnect.start();
       }
    }
    



As both HornetQ server and clients are in the same Virtual Machine, we use in-vm connections.
There will be only one port opened: the port used by Stomp (61613 by default)

To run the server, use Apache [Ant][ant]:


    
    
    $ ant server
       
    ...
    
    server:
       [java] 14 janv. 2010 10:57:30 org.hornetq.core.logging.impl.JULLogDelegate info
       [java] INFO: live server is starting..
       [java] 14 janv. 2010 10:57:30 org.hornetq.core.logging.impl.JULLogDelegate warn
       [java] ATTENTION: Security risk! It has been detected that the cluster admin user and password have not been changed from the installation default. Please see the HornetQ user guide, cluster chapter, for instructions on how to do this.
       [java] 14 janv. 2010 10:57:30 org.hornetq.core.logging.impl.JULLogDelegate info
       [java] INFO: HornetQ Server version 2.0.0.GA (Hornet Queen, 113) started
       [java] 14 janv. 2010 10:57:30 org.codehaus.stomp.tcp.TcpTransportServer doStart
       [java] INFO: Listening for connections at: tcp://BlackBook.local:61613
    



That's all you need to have a fully functional messaging server accessible to any Stomp clients.

To check that it works properly, we will use telnet as our Stomp client:


    
    
    $ telnet localhost 61613
    


      
First, we connect to the server.  
To keep things simple, we have disabled security from the server so that
we can connect to it anonymously:


    
    
    CONNECT
    login:
    passcode:
        
    ^@
    


     
(`^@` is Ctl-@)

The server replies that we are connected:


    
    
    CONNECTED
    session:null
    


     
We send a message to the destination `/queue/a`:


    
    
    SEND 
    destination:/queue/a
      
    hello, hornetq!
    ^@
    


     
To make things more interesting, you can now kill the server and restart it.
The message that was sent to the queue is persisted and will be consumed after the server is restarted.

Once the server is restarted, we open a new Stomp client and connect to the server:


    
    
    $ telnet localhost 61613
          
    CONNECT
    login:
    passcode:
         
    ^@
    


     
And we subscribe to the destination:
     

    
    
    SUBSCRIBE
    destination: /queue/a
    ack:client
         
    ^@
    


     
As soon as we are subscribed, we will receive the message that was sent to the destination:


    
    
    MESSAGE
    message-id:ID:7b28be24-00f1-11df-b27f-001c42000009:0000000000000000
    destination:/queue/a
    timestamp:1263462299779
    JMSXDeliveryCount:1
    expires:0
    subscription:/subscription-to//queue/a
    priority:4
         
    hello, hornetq!
    



Finally, we acknowledge the message:


    
    
    ACK    
    message-id: ID:7b28be24-00f1-11df-b27f-001c42000009:0000000000000000
         
    ^@
    



By leveraging HornetQ & Stomp, you can use messaging queues in your applications regardless on the platform you use.

One key decision of HornetQ was to make it simple to embed and integrate with other projects.
This simple example shows that we reach our goal with Stomp.

[hornetq]: http://jboss.org/hornetq/
[rh]: http://redhat.com/
[jms]: http://java.sun.com/products/jms/
[core-api]: http://hornetq.sourceforge.net/docs/hornetq-2.0.0.GA/api/
[hornetq-stomp]: http://github.com/jmesnil/hornetq-stomp
[stomp]: http://stomp.codehaus.org/
[stomp-clients]: http://stomp.codehaus.org/Clients
[ant]: http://ant.apache.org/


