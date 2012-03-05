---
date: '2008-05-27 21:18:38'
layout: post
slug: review-of-javascript-the-good-parts
status: publish
title: '⚑ Review of JavaScript: The Good Parts'
wordpress_id: '178'
tags:
- book
- javascript
---

[![](http://oreilly.com/catalog/covers/9780596517748_cat.gif)](http://oreilly.com/catalog/9780596517748/)

I admit: I don't like [JavaScript][wikipedia-js]. 

I have written and maintained very few scripts and it was a frustrating experience to have them working on several browsers.  
However this was many moons ago and I wanted to reevaluate JavaScript after using it in unexpected places (i.e. outside of the browser) like in [CouchDB View API][couchdb-view-api] or [Eclipse Monkey][eclipse-monkey] (I already wrote about [JMX scripts using Eclipse Monkey][jmx-with-eclipse-monkey]).

I was looking for a good book on _JavaScript, the language_.
There are many many books on JavaScript but they focus mainly on _JavaScript in the browser_ and spend thousands pages describing the DOM (please, Messrs. the editors, save the Amazon forest and just print some links to the online DOM documentation...).  
I wanted a concise book about writing simple and maintainable code. I also wanted to learn more about the weird syntax constructions spotted when reading non-trivial bits of code, such as [processing.js][processingjs] or [CouchDB View's map/reduce][couchdb-js].

I bought "[JavaScript: The Good Parts][javascript-good-parts]" on the strength of the [author][crockford]'s chapter in "[Beautiful Code][beautiful-code]" and I was not disappointed.  
This is exactly the kind of book I'm looking forward to when learning a programming language. It is short (100 pages + 50 pages of appendixes including [JSON][json] description) but dense, the sample code are small and meaningful (even the _done to death_ `fibonacci` and `factorial` functions used here to explain [memoization][memoization]).  
The book does not lose space describing extensively the whole language. It focuses on the subset which is good and proven and do not talk about the edges or the parts which are better forgotten. It really shows how to write code which is both readable, maintainable _and_ elegant.   
I'm sure I'll come back to this book every time I read JavaScript code using some peculiarities of the language that I don't understand.

After reading this book, I've got a better understanding of JavaScript and now sees the good (and even beautiful) parts of it.
I have a better appreciation for its prototype-based design even if it is hindered by a class-based syntax.  
I also find it frustrating that the JavaScript standard library is so useless (no I/O to communicate with the rest of the world). Of course, the library is richer when the code is to run in the browser or on Rhino (gaining access to the whole Java platform) but, by itself, the standard library is very poor compared to what comes bundled with [Python][python] or [Ruby][ruby].

These are critics of the language. For the book, I've got nothing but praises. I recommend it to any programmer wanting to learn more about what is good in JavaScript.

One advice about the code examples: it is much simpler to use [Spidermonkey][spidermonkey] or [Rhino][rhino] than the web browser to run the different scripts and experiment with them interactively.

[wikipedia-js]: http://en.wikipedia.org/wiki/JavaScript
[javascript-good-parts]: http://oreilly.com/catalog/9780596517748/
[couchdb-view-api]: http://wiki.apache.org/couchdb/HttpViewApi
[couchdb-js]: http://svn.apache.org/viewvc/incubator/couchdb/trunk/share/server/main.js?view=markup
[spidermonkey]: http://www.mozilla.org/js/spidermonkey/
[rhino]: http://www.mozilla.org/rhino/
[eclipse-monkey]: http://www.eclipse.org/dash/monkey-help.php?key=writing
[jmx-with-eclipse-monkey]: http://jmesnil.net/weblog/2007/05/23/jmx-scripts-with-eclipse-monkey/
[processingjs]: http://ejohn.org/blog/processingjs/
[io]: http://www.iolanguage.com/
[json]: http://json.org/
[memoization]: http://en.wikipedia.org/wiki/Memoization
[beautiful-code]: http://www.oreilly.com/catalog/9780596510046/
[crockford]: http://www.crockford.com/
[python]: http://python.org/
[ruby]: http://www.ruby-lang.org/fr/
