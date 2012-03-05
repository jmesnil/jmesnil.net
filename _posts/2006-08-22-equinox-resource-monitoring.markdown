---
date: '2006-08-22 14:45:51'
layout: post
slug: equinox-resource-monitoring
status: publish
title: ⚑ Equinox Resources Monitoring
wordpress_id: '141'
tags:
- eclipse
- java
- jmx
- osgi
---

Too much work is done around [Eclipse](http://eclipse.org) (RCP, Equinox, BIRT, Monkey) that I can't follow all the things which interests me.

However, by browsing the mailing list of the [Equinox](http://www.eclipse.org/equinox/) (Eclipse's [OSGi](http://www.osgi.org/) implementation), I discovered a cool new project in the Equinox incubator: [Resources Monitoring](http://www.eclipse.org/equinox/incubator/monitoring/index.php).

Its mission statement?

> To provide a framework for monitoring resources that are contributed by bundles installed on the host machine. The term 'resources' is used to
> describe something as specific as a single object or something as abstract as an OSGI bundle.

It seems to use [JMX](http://java.sun.com/products/JavaManagement/) to manage the resources and to provide both the server and the client code to manage the resources.

Definitively worth a look...
