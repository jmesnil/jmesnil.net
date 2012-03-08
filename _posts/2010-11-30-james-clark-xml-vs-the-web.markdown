---
date: '2010-11-30 21:29:11'
layout: post
slug: james-clark-xml-vs-the-web
status: publish
title: 'James Clark: XML vs the Web'
wordpress_id: '1429'
tags:
- web
- xml
---

James Clark:

> So what's the way forward? I think the Web community has spoken, and it's clear that what it wants is HTML5, JavaScript and JSON. XML isn't going away but I see it being less and less a Web technology; it won't be something that you send over the wire on the public Web, but just one of many technologies that are used on the server to manage and generate what you do send over the wire.

My background is in "enterprisey" Java and I use XML in Maven, Ant, configuration files, etc.
All the Java projects I worked had lots of code to map between XML and Java data structures.
I tried to use XML schema and bindings but it replaces some noisy boilerplate code by _other_ noisy boilerplate code. Using schema did help to enforce a structure but not all constraints can be expressed with it and I ended up having an additional programmatic validation phase in Java.

In comparison, working with JavaScript and JSON on the Web is much more simpler. I create JavaScript objects, send them over the wire with the string representation returned by `JSON.stringify()` and use again JavaScript objects on the server (with `JSON.parse()` in `node.js`  or using a JSON to Java library for Java servers).  
I don't have schema and I don't need it. A good documentation is enough in most cases (in the same way, I learn about a XML document by looking at its structure and documentation and rarely its schema).

I believe than XML (and its associated technologies) will end up as an  _enterprise_ technology and a _opaque_ content model (e.g. to save OpenOffice documents) and be less and less prevalent on the Web where HTML (with microformats) and JSON are better suited to represent data.

(via [John Gruber](http://daringfireball.net/linked/2010/11/30/clark-xml))

