---
layout: post
title: "Infinispan, Distributed Execution, and Messaging"
date: '2012-03-30 15:05:54'
category: 
tags: []
---

[Galder Zamarreño][galder], a colleague from Red Hat, presented [Infinispan][infinispan] yesterday at [AlpesJUG][alpesjug].

Watching his presentation reminded me of a conversation I had with an ex-colleague about messaging and distributed execution frameworks.

I have contributed to several messaging servers over the years, mainly on [HornetQ][hornetq]. During my previous job in a Web media company, I also used [Hadoop Map/Reduce][hadoop] for _Big Data_ processing.

With Big Data, the amount of data is so important that you can not process everything sequentially. Instead you parallelize the execution on several nodes.
In practice, this implies to _distribute the execution_: the  execution code (the mapper and reducer tasks) *moves* to the data nodes - where the data to process is stored - and runs locally.

With Messaging, you can achieve the opposite: to _distribute the data_. Messages containing the data are sent to consumers that will process them.
In many cases, the data transported inside the messages is not the data to process; it can be an event or contains the location of the data to process. Nonetheless, the result is the same: the execution code will not moved, it will fetch the data and process it on its own node. 

* _Messaging **moves the data** close to the execution code._
* _Distributed Execution **moves the execution code** close to the data._

If I understood Galder correctly, Infinispan proposes the two approaches:

* a [Map/Reduce model][infinispan-mr] where the mapper and reducer tasks are sent on the cluster nodes to distribute the code execution.
* [Listeners and Notifications][infinispan-l] that can be used as a __kind of__ messaging bus.

Messaging is a model that is widely used in entreprise applications and may become mainstream on the Web with the support of [Web Sockets][websockets] by all Web Browsers.  
Distributed execution framework like Hadoop Map/Reduce or Twitter [Storm][storm] *will* become mainstream as the amount of generated data to process and analyze (on the Web or behind firewalls for entreprise softwares) will continue to grow. 

Infinispan seems to hit a sweet spot by providing the two models and the ability to mix and match them. I am looking forward to seeing what's next for Infinispan and the best ways to leverage it...  

[galder]: http://galder.zamarreno.com/
[hornetq]: http://hornetq.org/
[infinispan]: http://www.jboss.org/infinispan
[infinispan-mr]: https://docs.jboss.org/author/display/ISPN/Infinispan+Distributed+Execution+Framework#InfinispanDistributedExecutionFramework-MapReducemodel
[infinispan-l]: https://docs.jboss.org/author/display/ISPN/Listeners+and+Notifications
[hadoop]: http://hadoop.apache.org/mapreduce/
[alpesjug]: http://www.alpesjug.org/
[websockets]: http://dev.w3.org/html5/websockets/
[storm]: http://engineering.twitter.com/2011/08/storm-is-coming-more-details-and-plans.html
