---
date: '2004-10-07 10:12:16'
layout: post
slug: using-eclipse-to-compare-two-files
status: publish
title: ⚑ Using Eclipse to compare two files
wordpress_id: '45'
tags:
- eclipse
---

I often need to compare two files to see their differences.  

The UNIX geek in me is using diff --side-by-side for that. But sometimes I want something more fancier with bright colors and easier to scroll.






[Eclipse](http://eclipse.org) provides a handy feature to compare two unrelated files  (e.g. not two CVS revisions of the same file) but it's quite difficult to find it first.  

To compare two files in Eclipse, select both files (Control click them) and in the contextual menu (right button), chose Compare With > Each Other. Et voila! you got a nicer diff than its CLI counterpart.



