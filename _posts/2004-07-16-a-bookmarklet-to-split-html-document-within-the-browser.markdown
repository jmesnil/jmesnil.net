---
date: '2004-07-16 22:18:19'
layout: post
slug: a-bookmarklet-to-split-html-document-within-the-browser
status: publish
title: A bookmarklet to split HTML document within the browser
wordpress_id: '27'
tags:
- javascript
- web
---

[**update**: the bookmarklets were broken for a long time but they now work again on Firefox 3 and Safari 3]

In a comment on his [blog](http://beust.com/weblog/archives/000153.html), I proposed to Cedric a simple solution to spilt a HTML page in two within the browser.
It’s just a one line JavaScript but it can be handy to use it,

[split document in new window](javascript:w=window.open('');w.document.write('<HTML><HEAD></HEAD><FRAMESET ROWS=\'50%,*\'><FRAME SRC=' + location.href + '><FRAME SRC=' + location.href + '>&lt/FRAMESET></HTML>');w.document.close();) -> drag to your bookmark folder





When you want to split a html document, click on the bookmark and you're done (it works on Safari and Firefox) 


 


Cedric then suggested to split the document in the current window. So here come two new bookmarklets:






  * [split horizontally in current window](javascript:document.write('<HTML><HEAD></HEAD><FRAMESET ROWS=\'50%,*\'><FRAME SRC=' + location.href + '><FRAME SRC=' + location.href + '></FRAMESET></HTML>');document.close();) -> drag to your bookmark folder



  * [split vertically in current window](javascript:document.write('<HTML><HEAD></HEAD><FRAMESET COLS=\'50%,*\'><FRAME SRC=' + location.href + '><FRAME SRC=' + location.href + '></FRAMESET></HTML>');document.close();) -> drag to your bookmark folder




