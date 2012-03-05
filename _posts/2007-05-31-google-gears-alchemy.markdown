---
date: '2007-05-31 09:47:22'
layout: post
slug: google-gears-alchemy
status: publish
title: ⚑ Google Gears & Alchemy
wordpress_id: '152'
tags:
- web
---

[Google](http://www.google.com) just released [Gears](http://gears.google.com) which  is :
> "an open source browser extension that enables web applications to provide offline functionality:
>
> *  Store and serve application resources locally
> * Store data locally in a fully-searchable relational database
> * Run asynchronous Javascript to improve application responsiveness".

At first glance, it seems to be the implementation of what [Adam Bosworth](http://www.adambosworth.net/) envisioned when he was talking about [BEA's Alchemy](http://www.eweek.com/article2/0,1895,1607676,00.asp) and [browser connectivity](http://www.adambosworth.net/archives/000023.html) (search for "When connectivity isn't certain" at the middle of the page).

Gears is already enabled for Google [Reader](http://www.google.com/reader/view/). I wonder how long it will take to have it supported in [Gmail](http://mail.google.com)...

Another potential use case for Gears is to develop [browser-based desktop applications](http://jmesnil.net/weblog/2005/01/new-breed-of-applications-browser.html). Their main data store will be provided by Gears database which could be synchronized from time to time to a web store. Office applications (document, spreadsheets, calendar) seem like good candidate for that approach: they'll feel faster and more responsive that way. Synchronizing them will only be done when (auto) saving the document/spreadsheet/event.

