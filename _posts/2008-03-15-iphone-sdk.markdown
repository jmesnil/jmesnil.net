---
date: '2008-03-15 17:35:43'
layout: post
slug: iphone-sdk
status: publish
title: iPhone SDK
wordpress_id: '166'
tags:
- apple
- iphone
- tangtouch
---

Since I've replaced my old PowerBook by a recent MacBook, I was looking for an opportunity to learn more about Objective-C and the cool new APIs from Leopard (especially [Core Animation][core-animation]).  
The release of the iPhone SDK is the right occasion to do that.

After a few hours of reading iPhone examples and coding, I was able to write a simple application to play [Tangram][tangram-wikipedia]:

![Play Tangram on the iPhone][tangram-iphone]

The game is not entirely functional: you can drag the parts from the "box" at the bottom to the top to arrange them and form shapes but you can't rotate the parts.   
Apple iPhone simulator can not simulate multi-gesture events corresponding to a rotation (put a finger down, with another finger draw an arc of circle).

There is nothing groundbreaking with this tiny application (it's not Spore or Monkey Ball!).
However, having never used XCode before and knowing not much about Objective-C and Mac OS X APIs, I was impressed by the quality of the iPhone SDK to be able to do that in less than 4 hours and 600 lines of code.

If I ever want to release this application one day, I guess I'll have to apply for the iPhone developer program... and buy an iPhone or an iPod touch!

[core-animation]: http://developer.apple.com/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html
[tangram-wikipedia]: http://en.wikipedia.org/wiki/Tangram	
[tangram-iphone]: /img/tangram_iphone.png
