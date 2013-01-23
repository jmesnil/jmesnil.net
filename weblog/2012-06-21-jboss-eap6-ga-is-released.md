---
layout: post
title: "JBoss EAP 6.0 GA is Released"
date: '2012-06-21 08:59:05'
category: 
tags: []
---

<figure style="max-width: 150px">
  <a href="http://www.redhat.com/products/jbossenterprisemiddleware/application-platform/"><img src="http://www.oracle.com/ocom/groups/public/@otn/documents/digitalasset/1666999.png" alt="JBoss by Red Hat"></a>
</figure>

It's official: [JBoss EAP 6.0 GA is released][mlittle]. One of its highlights is the integration of [HornetQ][hornetq] as its messaging provider. Using EAP6 means you can now have support from [Red Hat][redhat] for HornetQ.

I came back to Red Hat only a few months ago and did not contribute much to the HornetQ integration into the application server. This was a great collaboration between the AS and HornetQ teams to ensure the best experience to configure and use HornetQ.  
I'd even recommend to leverage EAP6 (or [JBoss AS 7.1][jbossas]) over standalone HornetQ servers. Wether you only need a messaging server or not, the management and deployment features brought by the AS are invaluable in production environment.

I wrote most of my contributions to EAP6 in HornetQ codebase during my first stint at Red Hat. I still remember the long hours, hard work and team work to release the best and fastest messaging provider. A few months later, we were able to reach this goal and I am happy to be back at Red Hat right on time to see the benefits of this work.

I can't wait to see what is coming next for JBoss and Red Hat.

[mlittle]: https://community.jboss.org/blogs/mark.little/2012/06/20/eap-60-ga
[hornetq]: http://jboss.org/hornetq/
[redhat]: http://www.redhat.com/
[jbossas]: http://www.jboss.org/jbossas
