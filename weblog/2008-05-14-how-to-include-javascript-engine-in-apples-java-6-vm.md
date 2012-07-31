---
date: '2008-05-14 13:22:33'
layout: post
slug: how-to-include-javascript-engine-in-apples-java-6-vm
status: publish
title: How to include JavaScript engine in Apple's Java 6 VM
wordpress_id: '175'
tags:
- apple
- java
- javascript
- macosx
---

After complaining in my [previous post][previous-post], here is a more constructive guide to use JavaScript with Apple's Java 6 VM:

1. Download [JSR 223's engines][jsr223]
2. Copy `jsr223-engines/javascript/build/js-engine.jar` to `/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/lib/ext/`
3. Download [Rhino][rhino]
4. Copy `rhino1_7R1/js.jar` to `/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/lib/ext/`

You can now use a "JavaScript" engine from Apple's Java 6 VM:

    public class JavaScriptTest {
        public static void main(String[] args) throws Exception {
            ScriptEngineManager factory = new ScriptEngineManager();
            ScriptEngine engine = factory.getEngineByName("JavaScript");
            engine.eval("print('hello, world!')");
        }
    }

`jrunscript` is also working:

        $ cd /System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/bin/
        $ ./jrunscript 
        rhino-nonjdk> print("hello, world");
        hello, world
        rhino-nonjdk> 
    

[previous-post]: http://jmesnil.net/weblog/2008/05/14/no-javascript-in-java-6-on-mac-os-x/
[jsr223]: https://scripting.dev.java.net/files/documents/4957/37593/jsr223-engines.zip
[rhino]: http://www.mozilla.org/rhino/download.html
