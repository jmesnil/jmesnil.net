---
date: '2008-05-14 12:39:03'
layout: post
slug: no-javascript-in-java-6-on-mac-os-x
status: publish
title: ⚑ No JavaScript in Java 6 on Mac OS X
wordpress_id: '173'
tags:
- apple
- java
- javascript
- macosx
---

I had an idea about using [JavaScript from Java 6][javascript-in-java6] and I wanted to give it a try on my MacBook.    
No such luck: Apple has recently released Java 6 for Mac OS X Leopard but somehow it does not include [Rhino][rhino], the Mozilla's JavaScript engine bundled in [Sun][sun] Java 6 release.

Instead they provided only one engine for [AppleScript][applescript] but frankly:

![](http://jmesnil.net/weblog/wp-content/uploads/2008/07/whocares1-300x122.png)


    
    
    public class AppleScriptTest {
        public static void main(String[] args) throws Exception {
            ScriptEngineManager factory = new ScriptEngineManager();
            ScriptEngine engine = factory.getEngineByName("AppleScript");
            engine.eval("tell application \"Finder\"\n display dialog \"Who cares?\"\n end tell");
        }
    }
    



Nuff said...

[rhino]: http://www.mozilla.org/rhino/
[javascript-in-java6]:
http://java.sun.com/javase/6/docs/technotes/guides/scripting/programmer_guide/index.html
[applescript]: http://www.apple.com/applescript/
[sun]: http://java.sun.com
