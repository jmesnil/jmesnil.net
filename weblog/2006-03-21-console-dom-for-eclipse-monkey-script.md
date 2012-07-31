---
date: '2006-03-21 23:59:06'
layout: post
slug: console-dom-for-eclipse-monkey-script
status: publish
title: Console DOM for Eclipse Monkey script
wordpress_id: '129'
tags:
- eclipse
---

I wrote a simple DOM to write message to Eclipse console from a [Monkey](http://eclipse.org/dash/) Script.

<strike>I have not yet created an update site for it so you have do [download it](/downloads/net.jmesnil.doms_0.0.1.jar) and install it in your plugins directory manually.</strike>  
It provides a `out` variable that you can use to write to a console.

Here is the mandatory "Hello, World" example:

<pre><code class='javascript'>--- Came wiffling through the eclipsey wood ---
/*
 * Menu: Console > Hello
 * Kudos: Jeff Mesnil
 * License: EPL 1.0
 * DOM: http://jmesnil.net/eclipse/updates/net.jmesnil.doms 
 */

function main() {
  out.print("Hello, ").println("World");
 }

--- And burbled as it ran! ---
</code></pre>

and its output

![Hello, World console screenshot](#{ site.s3.url }images/2006-03-21-console.png)
