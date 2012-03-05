---
date: '2006-03-01 11:40:47'
layout: post
slug: logging-templates-for-eclipse
status: publish
title: ⚑ Logging templates for eclipse
wordpress_id: '120'
tags:
- eclipse
---

Following [Wayne Beaton](http://wbeaton.blogspot.com/)'s post on [more templates with eclipse](http://wbeaton.blogspot.com/2006/02/more-code-templates-in-eclipse.html), here is an example of template that I extensively use in eclipse to ease logging statements.
For each logging level (debug, info, warn, error, fatal), I defined a corresponding templates.
For example, I have a `debug` template:

    if (logger.isDebugEnabled()) {
       logger.debug(${cursor});
    }

It makes it simpler and quicker to write logging statements.
However the class won't compile if a logger field has not already been defined.
But in that case, either you can use eclipse's quick fix... or create a new template to define 
the logger.
