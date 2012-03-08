---
date: '2005-01-07 10:19:18'
layout: post
slug: accepting-file-url-from-localhost-http-server
status: publish
title: Accepting file:// URL from localhost HTTP server
wordpress_id: '73'
tags:
- web
---

I have got a stupid problem: I have a HTTP server on localhost which serve web pages containing links to `file://` URLs.





[Firefox](http://mozilla.org/products/firefox/) refused to open these URLs (which is completely understandable to avoid security holes). In fact, you can't load them by clicking on the link but you can load them by dragging the URL to Firefox address bar.  

If I want to load them by click, I can bypass Firefox security by setting `security.checkloaduri` property to `false` (in `about:config` preferences page). However it will also expose this security hole to **any** HTTP server which is clearly not acceptable. What I'd like is that Firefox accepts to load `file://` URL from `http://localhost` **only** but not from any other HTTP server.




I can't find documentation to enable this... I need to look for another solution to this problem...
