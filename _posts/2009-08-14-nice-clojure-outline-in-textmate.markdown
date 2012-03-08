---
date: '2009-08-14 21:54:31'
layout: post
slug: nice-clojure-outline-in-textmate
status: publish
title: Nice Clojure Outline in TextMate
wordpress_id: '621'
tags:
- java
---

<div class="alignleft" style="font-size: 4em; padding: 10px;">
<a href="http://clojure.org"><img src='http://clojure.org/space/showimage/clojure-icon.gif' style="vertical-align:middle;" height="48" width="48"
/></a> + 
<a href="http://macromates.com"><img src='http://macromates.com/images/headlights/logo.png'  style ="vertical-align:middle;"  height="48" width="48"
 ></a>
</div>




[TextMate][mate] is my favorite text editor and my preferred IDE when I'm not writing Java or Objective-C (for these two, I use [Eclipse][eclipse] and [Xcode][xcode]).

I am currently learning [Clojure][clojure] and installed a [bundle][bundle] to have proper syntax highlighting and macros in TextMate.

I found a cool feature by accident yesterday.
My file was starting to be "big" and I added comments to separate the different "sections":


    
    
    ;; ************* ;;
    ;; Configuration ;;
    ;; ************* ;;
    
    ;; Configuration-related code
    
    ;; ********* ;;
    ;; DB Layer ;;
    ;; ********* ;;
    
    ;; DB-related code
    
    ;; *********** ;;
    ;; Web  Layer ;;
    ;; *********** ;;
    
    ;; Web-related code
    
    ;; ******* ;;
    ;; Startup ;;
    ;; ******* ;;
    
    (db/init)
    (server/start)
    



While I was writing code, I wanted to move from one part of the file to another and I used TextMate's outline for that (the outline is the right part of the status bar at the bottom of the window, when you click it, it displays a list of all defined functions in the file). I noticed that these special comments were also displayed:

<figure>
  <a href="{{ site.s3.url }}/images/2009-08-14-clojure-outline.png">
  <img src="{{ site.s3.url }}/images/2009-08-14-clojure-outline-300x242.png" width="300"></a>
  <figcaption>Clojure Outline in TextMate (click for full size)</figcaption>
</figure>

I don't know if the "magic" comes from TextMate or the Clojure bundle.
To make it appear in the outline, the comment must end with `;;`:  


    
    
    ;; This will appear in TextMate outline ;;
    
    ;; This won't
    



I tried several comment formats in Ruby code but I was not able to make them appear in the outline. I assume the kudos should go the the bundle's authors rather than to TextMate<sup id="fnr1-2009-08-14"><a href="#fn1-2009-08-14">1</a></sup>.

### Outline the "logical" structure of the code ###

It is a very good idea to display these comments in the outline as they help to show the logical structure of a file.

For example in  Java, the code is often organized as public/protected/private methods but it is does not give enough information on the _logical_ composition of the class. I add comments to delimit the various interfaces implementations:

{% highlight java %}
    class Foo extends Thread implements IFoo, IBar {
    
        // IFoo implementation
        ...
        // IBar implementation
        ...
        // Thread overrides
        ...
        // Public
        ...
        // etc.
        ...
    }
{% endhighlight %}    

This valuable information is not displayed in Eclipse, in its outline or any other views<sup id="fnr2-2009-08-14"><a href="#fn2-2009-08-14">2</a></sup>. This valuable information is lost while it would greatly improve the outline and make it more useful.

I already encountered such "special comments" when I was developing an iPhone application with Xcode. It supports a special preprocessor directive to display text in the outline:


    
    
    #pragma mark This will appear in Xcode outline
    
    // This is a regular Objective-C comment
    // it won't appear in the outline
    



I used them to split my Objective-C class in different logical sections (e.g. controller implementation, UI actions, protocol delegate):

<figure>
  <a href="{{ site.s3.url }}/images/2009-08-14-xcode-outline.png">
  <img src="{{ site.s3.url }}/images/2009-08-14-xcode-outline-300x198.png" width="300"></a>
  <figcaption>Objective-C Outline in Xcode (click for full size)</figcaption>
</figure>

I rarely uses code outline. Most of the time, I navigate in the code using the keyboard or the mouse wheel. Naturally, I prefer the outline to not clutter the UI  when I do not use it.  
However, when I want to use it, I prefer when it shows a "logical" outline of the code and not only a simple listing.

Compared to TexMate or Xcode, I find that Eclipse's outline is cluttered:

<figure>
  <a href="{{ site.s3.url }}/images/2009-08-14-eclipse-outline.png">
  <img src="{{ site.s3.url }}/images/2009-08-14-eclipse-outline-227x300.png" width="300"></a>
  <figcaption>Java Outline in Eclipse (click for full size)</figcaption>
</figure>

I can not use it without either maximizing the view or scroll it horizontally (both requires too much UI gestures before reading the outline).
I also find that it is overloaded with too much information:

* different icons for private/protected/public fields
* icon overlays for static, final modifiers or warnings
* nested hierarchy losing valuable UI space

All these details brings noise instead of information: an outline should display a general view of the class, not all these tiny details.

Using quite often these three softwares, I find TextMate and XCode approach to outlines more adapted to my workflow:

* they do not show it __until you require it__
* It displays a __logical view__ of the code (using the comments/directive to show the logical sections)
* it __does not show too much details__ not relevant to a broad view of the code

---

1. <a id="fn1-2009-08-14"></a>To be fair, TextMate deserves a meta-kudos to allow such cool features through its bundle mechanism!&nbsp;<a href="#fnr1-2009-08-14"  class="footnoteBackLink"  title="Jump back to footnote  in the text.">&#8617;</a>
2. <a id="fn2-2009-08-14"></a> I have not check if [NetBeans][netbeans] or [IDEA][idea] can display "special comments" in their outlines but I never heard about such a thing...&nbsp;<a href="#fnr2-2009-08-14"  class="footnoteBackLink"  title="Jump back to footnote  in the text.">&#8617;</a>

[clojure]: http://clojure.org
[mate]: http://macromates.com
[eclipse]: http://eclipse.org
[xcode]: http://developer.apple.com/TOOLS/Xcode/
[bundle]: http://github.com/stephenroller/clojure-tmbundle/
[netbeans]: http://www.netbeans.org/
[idea]: http://www.jetbrains.com/idea/

