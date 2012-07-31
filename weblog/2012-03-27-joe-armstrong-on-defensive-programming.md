---
layout: post
title: "Joe Armstrong On Defensive Programming"
link: http://erlang.org/pipermail/erlang-questions/2006-March/019844.html
date: '2012-03-27 14:49:35'
category: 
tags: []
---

> Note this method of structuring cannot be done in a sequential language
- since there is only one thread of control - thus in a sequential language all
error handling MUST be done *within* the process itself.  
> That's why you have to program defensively in a sequential language -
you get one
thread of control and one chance to fix your error.

> &mdash; <cite>Joe Armstrong</cite>

I can not warm up to [Erlang](http://www.erlang.org/) language and syntax but there is no denying that the Erlang worker/observer model is much more simpler and simple to figure out that code which mixes business logic and error handling.

(via [@debasishg](https://twitter.com/debasishg/statuses/184323422787092480))
