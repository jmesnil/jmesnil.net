---
date: '2005-01-03 11:49:29'
layout: post
slug: osgi-framework-to-improve-java-platform
status: publish
title: OSGi framework to improve Java platform
wordpress_id: '77'
tags:
- osgi
---

I saw this [thread](http://forums.java.net/jive/thread.jspa?messageID=8987&tstart=0#8987) of Java.net community forums about missing features to administrate libraries in Java.  

[OSGi](http://www.osgi.org) helps with two shortcomings of the _Java platform_ (not Java _language_):





  
  * Component Versioning

  
  * Published Interfaces





### Component Versioning





There is already a notion of [versioning](http://java.sun.com/j2se/1.3/docs/guide/extensions/versioning.html) in [Jar specification](http://java.sun.com/j2se/1.3/docs/guide/jar/jar.html). But I'm not aware of _simple_ tools to take advantage of it (a.k.a "write you own ClassLoader").  


With OSGi, you can state the version of the bundle you want to import. It also takes into account compatible versions. Since bundles have their own classloaders, you can have different bundles using different versions of the same library without conflict.





### Published Interfaces





Another useful feature of OSGi bundles is the idea of published API (see Martin Fowler's article ["Public versus Published Interfaces"](http://www.martinfowler.com/ieeeSoftware/published.pdf) for a definition of published interface).  

You have to state in the manifest of your bundle the packages of the other bundles you're depending on. Your bundle can then only load classes from these packages and not from any other packages.   


Eclipse plug-ins makes the distinction by putting their published interfaces in `org.eclipse._foo_` package and the public API in `org.eclipse._foo_.**internal**`.
  

It is not recommended to make your plug-in dependant of internal packages but you still have the freedom to do so _at your own risk_ if you really need it (e.g. to circumvent a bug or to extend the plug-in if it does not expose a feature as an extension point).





I really like the idea to make an explicit distinction between the public interfaces of a component and the published ones.  

These days, thanks to autocompletion in the IDEs you can inadvertantly import and use a part of a component which is not meant to be used by its clients.  

With OSGi, you can't use a package if it's not explicitely stated in the `import-package` header of its manifest file. Of course, you can still import internal packages but it has to be done explicitely in the manifest file.
The advantage of OSGi is that with a quick look at the manifest file, you can see the boundaries of your bundle:



  
  * what it depends on

  
  * what it provides (at package level)


While with "standard" jars, it is more difficult to see all its dependencies in one look.





Since Eclipse 3.0, OSGi framework has been under my radar but I hadn't had the opportunity to develop an application based on it. I'm not aware of Open Source applications based on top of OSGi (other than Eclipse) but I think there is a lot of potential to develop an application on top of it. Not only for the two features I described but for a lot of other reasons (hot deployment, remote administration).  

Another cool example is that application help could be written in HTML and available as a Bundle taking advantage of OSGi embedded web container (e.g. like Eclipse Help).
That way, you have simple to write documentation without the need to keep all the versions of the documentation of the available versions of your application on your web site.
