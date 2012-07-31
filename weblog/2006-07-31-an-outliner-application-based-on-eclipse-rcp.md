---
date: '2006-07-31 19:06:05'
layout: post
slug: an-outliner-application-based-on-eclipse-rcp
status: publish
title: An Outliner application based on Eclipse RCP
wordpress_id: '139'
tags:
- eclipse
- java
---

While cleaning up my workpace, I (re) discovered a small application I wrote to familiarize myself with Eclipse editors development.
  
It is a simple outliner which reads and writes OPML files. Each OPML file is opened in an Eclipse Editor. You can navigate the outliner, indent/outdent the outlines, create new outlines and edit them.  
To toggle between the edition and the navigation modes, you can use the ESC key (like in vi).


![Eclipse Outliner Screenshot](http://jmesnil.googlepages.com/eclipse-outliner.jpg/eclipse-outliner-large.jpg)


The code is pre-pre alpha (hence the 0.1.1 version) and a lot of essential features are missing:

* no copy/paste
* The OPML parser is home-made and parses only a subset of [OPML 2.0](http://www.opml.org/spec2) (but at least, I can read some OPML 2.0 examples such as [states.opml](http://hosting.opml.org/dave/spec/states.opml))
* I pretty sure that the generated OPML is not valid

The fun part of the application is the [OutlinerEditor](http://eclipse-outliner.googlecode.com/svn/trunk/net.jmesnil.outliner.ui/src/net/jmesnil/outliner/ui/editors/OutlinerEditor.java). Each OutlinerEditor is composed of a TreeViewer which displays the outline.
The TreeViewer is not editable but each cell of the tree can be edited in place (a la [SWT snippet #111](http://dev.eclipse.org/viewcvs/index.cgi/%7Echeckout%7E/org.eclipse.swt.snippets/src/org/eclipse/swt/snippets/Snippet111.java)).

I released this project on [Google Code's project hosting](http://code.google.com/hosting/) under the Apache License 2.0 and created a corresponding [web site](http://jmesnil.googlepages.com/eclipseoutliner) to complement the [project home](http://code.google.com/p/eclipse-outliner/).
You can check it out using Subversion but to make it simpler to check out, you can import in your workspace the [Outliner Team Project Set](http://jmesnil.googlepages.com/eclipseoutliner.psf) (provided you have a Subversion plug-in like [Subclipse](http://subclipse.tigris.org/)).
I don't plan to work extensively on this application but I thought it could be of some interest for new Eclipse RCP developers.

I developped the application on Mac OS X and had the bad surprise to see that the application is not working properly on Linux  because I can't navigate the tree with the arrow keys (see issue [#3](http://code.google.com/p/eclipse-outliner/issues/detail?id=3&can;=2&q;=)).
It seems to be a "bug" in SWT since I can't navigate with the arrow keys in SWT snippet #111 either.  Though I'm not sure this is a SWT bug or a platform specific behavior...
