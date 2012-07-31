---
date: '2009-07-06 17:02:28'
layout: post
slug: concurrency-is-my-new-memory-management-criteria
status: publish
title: Concurrency Is My New Memory Management Criteria
wordpress_id: '476'
tags:
- java
---

Way back in school, I started studying object-oriented programming language with [C++][cplusplus].
I found the object concepts simple and powerful (especially after learning procedural programming with [Fortran][fortran]) but I did not like C++.

I browsed the internet to find if there were other OO languages that I could use instead of C++. I quickly found [Java][java] (1.0.x at the time, if I remember correctly) and preferred it for 3 reasons:

1. the concept and syntax were similar to C++ but simpler and well-defined. I could still leverage what I learn with C/C++ and applied it to Java
2. the documentation was good: with the javadoc, the whole platform API was one-click away
3. it had an _automatic garbage collector_

So I started to study Java seriously during my spare time, I found internships where I could learn from other Java developers and I ended up using it for most of my professional career.

Retrospectively, reasons #1 and #2 were nice to have but _automatic garbage collection was the real decision criteria_.

When I develop an application, most of the time I don't care when I should allocate objects, if should I take ownership or release them, etc. I just want to have an object and use it<sup id="fnr1-2009-07-06"><a href="#fn1-2009-07-06">1</a></sup>. 

But C++ forced me to think about all these details while Java made it simpler: `new Foo()` and that's it. Back then, I was just starting to learn programming languages and I preferred to let the languages handle the memory: it would be less error-prone than if I had to do it manually.

My student friends told me that my Java programs would consume more memory than the C++ equivalent and likely run slower. Maybe it was true at the time, but the Java programs were simpler and faster to write, less buggy and less likely to leak memory during their lifetime.  
So I chose Java and never looked back to C++.

Back to the present.

We now have multiple cores in our machines and to use them efficiently, we need to increase the concurrency of our code.

And I'm not enthusiastic with Java. The `java.util.concurrent` library helps a lot but I find __really hard to write correct concurrent code__ and __too easy to screw it up__.
I'm in the same state of mind that when C++ was "forcing" me to think about memory management. 

I have added other languages to my toolbox (mainly [Ruby][ruby]/[JRuby][jruby] and [Javascript][javascript]). They complement nicely Java but they are not more fit for concurrency.
There should be a language/platform that can handle concurrency for me or at least help me write correct concurrent code.

Which languages/platform will I use for that? [Erlang][erlang], [Clojure][clojure]<sup id="fnr2-2009-07-06"><a href="#fn2-2009-07-06">2</a></sup>, [Scala][scala], [Reia][reia], other?   
Which concepts should I use? [STM][stm], [messages][messages], [actors][actors], [fork/join][fork-join], [Grand Central Dispatch][grand-central], other?  
I don't even know if I am looking for a new platform or another language on top of the Java platform.

But I know that I am looking for _something_ to help me with concurrency the same way Java helps me manage the memory.

Concurrency is likely to be one of the main decision criteria when I choose which next language/platform to learn.
I envision it being as important as memory management was when I started to learn OO and how it tipped the balance for Java instead of C++.

Choosing Java over C++ shaped the beginning of my career. Choosing a concurrent language/platform may have the same importance for the next part of it...

---

   1. <a id="fn1-2009-07-06"></a> I waited the release of  [Objective-C 2.0][objective-c] to learn about Mac programming. I wanted to learn this language since I bought my first Powerbook but I waited until they added a garbage collector because I was not interested to manually manage the memory. Finally I still ended up having to learn it since the garbage collector is not available on the iPhone. Unsurprisingly, I have to track down a few memory leaks in the iPhone applications I develop.&nbsp;<a href="#fnr1-2009-07-06"  class="footnoteBackLink"  title="Jump back to footnote  in the text.">&#8617;</a>
   2. <a id="fn2-2009-07-06"></a> I received the printed version of [Programming Clojure][programming-clojure] a few days ago. I like what I am reading so far.&nbsp;<a href="#fnr2-2009-07-06"  class="footnoteBackLink"  title="Jump back to footnote  in the text.">&#8617;</a>

[cplusplus]: http://en.wikipedia.org/wiki/C%2B%2B
[fortran]:  http://fr.wikipedia.org/wiki/Fortran
[java]:  http://java.net/
[erlang]: http://erlang.org/
[clojure]: http://clojure.org/
[scala]: http://www.scala-lang.org/
[reia]: http://wiki.reia-lang.org/wiki/Reia_Programming_Language
[objective-c]: http://developer.apple.com/documentation/Cocoa/Conceptual/ObjectiveC/Introduction/introObjectiveC.html
[ruby]: http://www.ruby-lang.org/en/
[jruby]:  http://jruby.org/
[javascript]: http://en.wikipedia.org/wiki/JavaScript
[stm]: http://en.wikipedia.org/wiki/Software_transactional_memory
[actors]: http://en.wikipedia.org/wiki/Actor_model
[messages]: http://en.wikipedia.org/wiki/Message_passing
[fork-join]: http://gee.cs.oswego.edu/dl/papers/fj.pdf
[grand-central]: http://www.apple.com/macosx/technology/#grandcentral
[programming-clojure]: http://www.pragprog.com/titles/shcloj/programming-clojure
