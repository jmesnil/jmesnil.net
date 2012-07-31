---
date: '2010-08-05 16:49:16'
layout: post
slug: java-api-trade-off-between-ugliness-and-durability
status: publish
title: Java API, Trade-Off Between Ugliness and Durability
wordpress_id: '1184'
tags:
- java
---

In my [previous post][previous], I complained that JMX API was not consistent about the return types of `DynamicMBean`'s `getAttribute()` and `getAttributes()` methods.

[Eamonn McManus][eamonn] [replied][comment] with a very good explanation on why `getAttributes()` is designed that way in order to be consistent with _`setAttributes()`_. This bit of "ugliness" in the API is a very good compromise. It requires some attention from the API user but it helps tremendously developers providing MBeans as they don't have to deal with the atomicity of setting different attribute values.
I would still object that `getAttribute()` should have been consistent and return an `Attribute` instead of the value. But I can understand that the `Attribute` indirection has no purpose  in that case.

I like JMX API for that reason: it's both simple and flexible. There are some parts which are ugly or require more work than I would like (writing an [OpenMBean][OpenMBean] is a chore with too much information that should be handled by the JVM or JMX library) but I understand that JMX is widely used and backwards compatibility is a mandatory requirement.
If every new release of Java was coming with a refined JMX API without a regard to backwards compatibility, I would not praise it like I do.

Writing an API both simple and empowering is hard. Support it over several releases is a tremendous task.In the Java world, [Eclipse][eclipse] is the front leader on that task. 

Several years ago, I developed a plug-in, [eclipse-jmx][eclipse-jmx], to manage JMX application inside Eclipse (it is also integrated into [JBoss Tools][jboss-tools] as its [JMX tool][jmx-tool]).
And release after release, it is still supported by Eclipse _without any changes to the API calls_.

The last release of eclipse-jmx was written against Eclipse 3.2 and __3 years and 4 Eclipse releases later__, eclipse-jmx still works fine, you can even install it using Eclipse Marketplace.
I have a love/hate relationship with Eclipse as I use it everyday but I have only admiration for its developers who have been able to craft such a software and took on themselves to support APIs over long time and multiple versions instead of pushing all the work to the contributors to constantly update their plug-ins for each new release. The beauty of [Eclipse APIs][eclipse-api] is in their durability and resiliency.

If you want to know how to write great Java API, the best resources to start are [Eclipse][eclipse-api] and [JMX][jmx-api].

On a similar topic, I am having a deep look at HTML5 and its various JavaScript APIs (WebSockets, geolocation, storage, canvas, etc.). I am curious to see how they will evolve and if lessons will have been learnt from the evolution (or lack of) of the DOM API...

[previous]: http://jmesnil.net/weblog/2010/08/02/jmx4r-0-1-2-is-released/
[comment]: http://jmesnil.net/weblog/2010/08/02/jmx4r-0-1-2-is-released/#comment-77839
[eamonn]: http://www.java.net/blogs/emcmanus/
[openmbean]: http://download-llnw.oracle.com/javase/1.5.0/docs/api/javax/management/openmbean/package-summary.html#package_description
[jmx-api]: http://www.artima.com/weblogs/viewpost.jsp?thread=142428
[eclipse]: http://eclipse.org/
[eclipse-api]: http://wiki.eclipse.org/Evolving_Java-based_APIs
[eclipse-jmx]: http://github.com/jmesnil/eclipse-jmx
[jboss-tools]: http://jboss.org/tools
[jmx-tool]: http://docs.jboss.org/tools/3.1.0.GA/en/jmx_ref_guide/html/index.html

