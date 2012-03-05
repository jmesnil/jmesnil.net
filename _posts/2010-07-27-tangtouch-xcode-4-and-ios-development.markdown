---
date: '2010-07-27 23:19:32'
layout: post
slug: tangtouch-xcode-4-and-ios-development
status: publish
title: ⚑ TangTouch, Xcode 4 and iOS Development
wordpress_id: '1138'
tags:
- misc
---

With the releases of [iOS 4][ios] and a developer preview of [Xcode 4][xcode], I am doing some Mac development again.

As I have a few ideas I want to try on iOS 4, I had to renew the Apple <strike>ransom</strike> <strike>tax</strike> developer license to be able to put my _own_ code on my own _device_ but I digress...

I took the opportunity to update [TangTouch][tangtouch] (iTunes link), the game I wrote to learn iPhone development, to support iOS 4. 

![](http://iphone.jmesnil.net/img/img-1.png)

There has been several releases of the iOS (ne iPhone OS) since I wrote this application but the APIs are fairly stable and I had to change a few deprecated calls only. As a bonus, it now supports multitasking: if you leave the game and come back later, the game will be as you left it.  
I released the new version on the App Store. This game was a learning tool and it shows a lack of polish (I am by no means a graphic designer). The game is free so that I don't have to refund it if people do not like it :)

Apple has also released a developer preview of Xcode 4 that I am evaluating. Xcode 4's user interface was redesigned by switching to a single window instead of cluttering the desktop with many windows. The window layout modes are surprising (for example, to display corresponding `.m` and `.h` files next to each other) and I have not decided which ones I preferred to use. I still have issues to run Interface Builder inside with XCode 4 ,so I revert to Xcode 3.2 to do some UI work.

I was also interested to see how [Git][git] was integrated as I use it for all my personal projects.
The user interface to browse a file history is innovative (and fast!), reminding of [Time Machine][timemachine]:

![](http://jmesnil.net/weblog/wp-content/uploads/2010/07/version1.png)

At the moment, Git integration is fairly limited. Xcode does not seem to handle Git branches and stashes. I did not find how to browse the whole project either and it does not seem possible to add remote repositories as only the local Git repository is used (no push or pull to remote repositories).
I hope that Apple will fully embrace Git and expose in a clean way all its features. At the moment, [GitX][gitx] and the command line are still the best way to interact with Git: I develop first and organize my commits later (to add interactively, merge commit, rebase, etc.).  

Coming from a Java background, it is always fun and very interesting to dive into other environments.
I appreciate how well-designed Cocoa APIs are (especially compared to so many Java & JEE APIs...) and I like Objective-C even though its incidental complexity is close to Java.
It really is the APIs and the developer tools that make it worthwhile to develop on iOS and Mac and have fun while doing it.

[tangtouch]: http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=292658907&mt;=8
[git]: http://git-scm.com/
[xcode]: http://developer.apple.com/technologies/tools/whats-new.html
[ios]: http://www.apple.com/iphone/ios4/
[gitx]: http://gitx.frim.nl/
[timemachine]: http://www.apple.com/macosx/what-is-macosx/time-machine.html
