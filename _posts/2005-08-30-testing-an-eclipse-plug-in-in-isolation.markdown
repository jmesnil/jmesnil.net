---
date: '2005-08-30 18:14:39'
layout: post
slug: testing-an-eclipse-plug-in-in-isolation
status: publish
title: Testing an Eclipse plug-in in isolation
wordpress_id: '103'
tags:
- eclipse
---

All this post just to ask a simple question: how to test an Eclipse plug-in in isolation?




I'm currently writing an Eclipse feature to manage a server through JMX.
It is composed of 3 plug-ins:






  * the _JMX plug-in_ is used to create on demand the MBean proxies and handle all the low-level JMX stuff (connections, authentication, etc.)


  * the _Core plug-in_ is my domain model. it provides core objects which, in addition of the management methods of the MBeans, provide navigation methods to easily move between them (the core objects are in a way proxies of the MBean proxies...)


  * the _UI plug-in_ uses the core objects provided by the _Core plug-in_ for display and user interaction.




As an aside, I don't use the MBeans directly as my domain model. To have an object-oriented domain model has two advantages:


1. the navigation between the objects is simple to use and self-described by the API
2. I can integrate better with Eclipse since my core objects implements `IAdaptable` (adapters are implemented in the _UI plug-in_)



So I'd like to test the _Core plug-in_ in isolation to ensure the consistency of my domain model based on the MBeans. However I don't want to use the "real" MBeans because most of the code I want to test is destructive and will alter the state of the managed objects on the server side making it too much difficult to run tests in isolation.





My first idea was to mock the _JMX plug-in_ so that it returns mocked MBeans that I can use to unit test the Core plugin.  

It sounds quite simple but I haven't yet find a way to make it work...





The first dirty hack that I tried was to create a _JMX Mock plug-in_ with the same ID and API than the real _JMX plug-in_ and use that one in the test launch configuration but Eclipse is (understandingly!) not happy about having two plug-ins with the same ID. Anyway, it is ugly because the _JMX Mock plug-in_ wouldn't have any relation with the real _JMX plug-in_ but a copy-paste...




Another dirty solution would be that the JMX plug-in itself could either return the real MBeans or the mocked ones. But is is so ugly and wrong that I _really_ don't want to go that way...




I searched on Google and Eclipse mailing lists about ways to test Eclipse plug-ins in isolation but I didn't found any good advices.  

In fact I haven't found information about mocked plug-in (but thousands and thousands of plug-ins generating mocks, sigh...).




All that said, I just have two simple questions:






  * how to test a plug-in in isolation?


  * how to provide a mocked plug-in which is injected in another plugin at runtime?




Disclaimer: I'm relatively new at plug-ins development and I really  wonder if I'm not missing something obvious for experienced plug-ins developers...)




