---
date: '2005-01-04 22:31:24'
layout: post
slug: more-on-osgi-and-component-versioning
status: publish
title: More on OSGi and Component Versioning
wordpress_id: '75'
tags:
- osgi
---

What I said in my last entry concerning [OSGi and Component Versioning](http://www.jmesnil.net/weblog/2005/01/osgi-framework-to-improve-java.html) is not accurate (not to say completely wrong).  

I wrote that:




> 
With OSGi, you can state the version of the bundle you want to import. It also takes into account compatible versions. Since bundles have their own classloaders, you can have different bundles using different versions of the same library without conflict.






To check that, I wrote some bundles and it does not work that way.  

As is stated in OSGi specification:




> 
A bundle may offer to export all the classes and resources in a package by  specifying the package names in the Export-Package header in its manifest.  For each package offered for export, the Framework must choose one bundle that will be the provider of the classes and resources in that package to  all bundles which import that package, or other bundles which offer to  export the same package.



and


> 
If more than one bundle declares the same package in its Export-Package  manifest header, the Framework controls the selection of the exporting  bundle. The Framework must select for export the bundle offering the highest version of the declared package. 






If I read it correctly, that means that you can only have one version of a given exported package identified by the highest `specification-version` value.   

So OSGi won't help to solve runtime dependencies nightmare experienced by anyone using different projects, each one depending on different versions of [Jakarta](http://jakarta.apache.org/) commons jars...






So next time, I'll first RTBS, then write some code and finally blog about it instead of blogging first...





P.S.: OSGi versioning is based on [Java Product Versioning Specification](http://java.sun.com/j2se/1.4.2/docs/guide/versioning/spec/versioning.html) which is worth reading...




