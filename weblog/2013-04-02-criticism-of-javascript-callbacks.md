---
layout: post
title: "Criticism of JavaScript callbacks"
date: '2013-04-02 16:37:18'
category: 
tags: []
---

I read two interesting articles about the shortcomings of JavaScript callbacks. I played a bit with [node.js][nodejs] and I find that the use of callbacks makes the code more convoluted that it could be.

* Joe Armstrong compares use of [callbacks in Erlang and JavaScript][red-green]
* A nice [introduction to promises in JavaScript][promises] and how they could untangle callback hell (especially in node.js)

I find Erlang's mailbox approach simpler to understand and read (but I can not warm up to Erlang syntax...).

Promises looks... promising but I'd like to try them out on a pet project to get a better feel on them. In France, we have a saying that said that _"promises bind only whose that listen to them"_, so I prefer to be cautious :)

[nodejs]: http://nodejs.org
[red-green]: http://joearms.github.com/2013/04/02/Red-and-Green-Callbacks.html
[promises]: http://blog.jcoglan.com/2013/03/30/callbacks-are-imperative-promises-are-functional-nodes-biggest-missed-opportunity/