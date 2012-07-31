---
date: '2004-12-14 10:07:56'
layout: post
slug: firefox-save-as-different-behaviors
status: publish
title: Firefox "Save as..." different behaviors
wordpress_id: '60'
tags:
- web
---

Following my [latest blog](http://www.jmesnil.net/weblog/2004/12/local-crc-cards-whiteboard.html), I discovered that [Firefox](http://mozilla.org/products/firefox) handles differently saving a file if you save it as _HTML only_ or as a _complete_ Web page.  

If you specify `HTML only`, it saves the static content of the page (what was loaded at first in the browser). It _does not_ save the DOM of the page.  

However, if you specify `complete Web Page`, it is the DOM of the page which is saved (including generated content of the page). The disadvantage of that approach is that it'll also save the scripts which are used in the file **locally** in a `*_files` directory instead of  keeping the original URL of the scripts in the HTML file. That means that this page is no longer self-contained and you can't send it to someone else. You also need to keep the `*_files` close or the JavaScript parts of the page won't work anymore...




What I'd like is to be able to save the DOM of the page but also keep the original URL of scripts. I need to dig into Firefox to see if there are ways to configure its saving behavior...
