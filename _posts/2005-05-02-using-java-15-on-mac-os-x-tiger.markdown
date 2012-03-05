---
date: '2005-05-02 20:12:21'
layout: post
slug: using-java-15-on-mac-os-x-tiger
status: publish
title: ⚑ Using Java 1.5 on Mac OS X Tiger
wordpress_id: '93'
tags:
- apple
- java
- macosx
---

Since I upgraded to Mac OS X Tiger, I also installed [Java 1.5](http://www.apple.com/support/downloads/java2se50release1.html) on my PowerBook.

Apple provides a small application to change the default JVM to 1.5 instead of the standard 1.4.2. However it is only useful for Applets and WebStart applications.
To change the default JVM for the CLI and Java applications such as Eclipse, I also had to change a symlink.

    
    <code>
    $ cd /System/Library/Frameworks/JavaVM.framework/Versions
    $ sudo mv Current Current.old
    $ sudo ln -s 1.5 Current
    </code>



Et voila!


    
    <code>
    $ java -version
    java version "1.5.0_02"
    Java(TM) 2 Runtime Environment, Standard Edition (build 1.5.0_02-56)
    Java HotSpot(TM) Client VM (build 1.5.0_02-36, mixed mode, sharing)
    </code>
