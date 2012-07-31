---
layout: post
title: "How To Enable STOMP Messaging Protocol in JBoss AS7"
date: '2012-05-03 14:30:16'
---

Since I have started working on [AS7][as7], I have been pleasantly surprised by its ease of configuration. My favorite thing about AS7 (after its fast boot time) is that its configuration is located into a single file.

If you need messaging with AS7, you can use its `standalone/configuration/standalone-full.xml` configuration file which contains a messaging stack built on top of [HornetQ][hornetq].
The whole messaging stack is configured in its messaging `<subsystem>`:

<pre><code class='xml'>&lt;subsystem xmlns="urn:jboss:domain:messaging:1.2">
    &lt;hornetq-server>
        ...
    &lt;hornetq-server>
&lt;/subsystem>
</code></pre>

By default, AS7 only supports JMS as its messaging protocol.
If your applications needs to send and receive messages from other platforms or languages than Java, JMS is not an option and you need to enable [STOMP][stomp] too.

Fortunately, adding STOMP support to AS7 is dead easy:

1. add an HornetQ acceptor to let AS7 accept STOMP frames on a dedicated socket
2. configure this socket to bind to default STOMP port

To add an HornetQ acceptor for STOMP, edit the `standalone/configuration/standalone-full.xml` file and add these lines in the `<acceptors>` section of `<hornetq-server>`:

<pre><code class='xml'>&lt;netty-acceptor name="stomp-acceptor" socket-binding="messaging-stomp">
    &lt;param key="protocol" value="stomp"/>
&lt;/netty-acceptor>
</code></pre>

The `stomp-acceptor` is expected to receive STOMP frames on the socket binding named `messaging-stomp`.

At the end of the same `standalone/configuration/standalone-full.xml` file, add a `<socket-binding>` to the `<socket-binding-group name="standard-sockets">` section:

<pre><code class='xml'>&lt;socket-binding name="messaging-stomp" port="61613"/>
</code></pre>

`61613` is the default port for Stomp brokers.

With these 2 changes, we can now start JBoss AS7 with STOMP enabled:

<pre><code class='bash'>$ <kbd>./bin/standalone.sh -c standalone-full.xml</kbd>
...
14:14:38,027 INFO  [org.hornetq.core.remoting.impl.netty.NettyAcceptor] (MSC service thread 1-2) Started Netty Acceptor version 3.2.5.Final-a96d88c 127.0.0.1:61613 for STOMP protocol
...
14:14:38,263 INFO  [org.jboss.as] (Controller Boot Thread) JBAS015874: JBoss AS 7.1.2.Final-SNAPSHOT "Brontes" started in 2749ms - Started 163 of 251 services (87 services are passive or on-demand)
</code></pre>

Before sending and receiving messages from a STOM client, we also need to configure 2 things for the AS7:

1. add an user (AS7 is secured by default and we must explicitely add an application user to connect to it)
2. add a JMS queue to send and receive messages on it

To add an user, we use the `add-user.sh` tool:

<pre><code class='bash'>$ <kbd>./bin/add-user.sh</kbd>

What type of user do you wish to add?
 a) Management User (mgmt-users.properties)
 b) Application User (application-users.properties)
(a): <kbd>b</kbd>

Enter the details of the new user to add.
Realm (ApplicationRealm) : <kbd>[type enter]</kbd>
Username : <kbd>myuser</kbd>
Password : <kbd>mypassword</kbd>
Re-enter Password : <kbd>mypassword</kbd>
What roles do you want this user to belong to? (Please enter a comma separated list, or leave blank for none)[  ]: <kbd>guest</kbd>
About to add user 'myuser' for realm 'ApplicationRealm'
Is this correct yes/no? <kbd>yes</kbd>
Added user 'myuser' to file '[...]/standalone/configuration/application-users.properties'
Added user 'myuser' to file '[...]/domain/configuration/application-users.properties'
Added user 'myuser' with roles guest to file '[...]/standalone/configuration/application-roles.properties'
Added user 'myuser' with roles guest to file '[...]/domain/configuration/application-roles.properties'
</code></pre>

Finally, to add a JMS queue, we will use JBoss CLI tool:

<pre><code class='bash'>$ <kbd>./bin/jboss-cli.sh</kbd>
You are disconnected at the moment. Type 'connect' to connect to the server or 'help' for the list of supported commands.
[disconnected /] <kbd>connect</kbd>
[standalone@localhost:9999 /] <kbd>/subsystem=messaging/hornetq-server=default/jms-queue=test/:add(entries=["/java:jboss:exported/queue/test"])</kbd>
{"outcome" => "success"}
</code></pre>

We now have configured an user and a JMS queue. Let's send and receive STOMP messages using Ruby and its `stomp` gem (installed with `sudo gem install stomp`):

<pre><code class='ruby'>require 'rubygems'
require 'stomp'

client = Stomp::Client.new "myuser", "mypassword", "localhost", 61613

client.publish 'jms.queue.test', 'Hello, STOMP on AS7!'

client.subscribe "jms.queue.test" do |msg|
  p "received: \#{msg.body}"
end
</code></pre>

And it will output the expected message:

<pre><code class='bash'>received: Hello, STOMP on AS7!
</code></pre>

## Conclusion

1. add a `<netty-acceptor>` with a `stomp` protocol param
2. add a `<socket-binding>` for default 61613 STOMP port
3. configure users and JMS queues by following [AS7 messaging documentation][doc]

Using STOMP with AS7 is simple to setup (4 lines to add to its configuration file) and allow any languages and platforms to send and receive messages to your application hosted in AS7.

[hornetq]: http://jboss.org/hornetq/
[stomp]: http://stomp.github.com/index.html
[as7]: http://jboss.org/jbossas
[doc]: https://docs.jboss.org/author/display/AS71/Messaging+configuration

