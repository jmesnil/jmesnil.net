---
date: '2006-03-21 02:15:37'
layout: post
slug: hook-when-hovering-on-a-menu-item-in-eclipse
status: publish
title: Hook when hovering on a menu item in Eclipse
wordpress_id: '127'
tags:
- eclipse
---

I'm trying to display a message in Eclipse global status bar when hovering on a menu item.

I had the part to display the message (but I'm pretty sure it's the ugliest way I could have found):

		if (window instanceof ApplicationWindow) {
			ApplicationWindow appWindow = (ApplicationWindow)window;
			appWindow.setStatus(message);
		}

But I can't find how to run that code when hovering on a menu item.
I've got the complete control on the menu and its items creation but I don't see where I can plug my code so
that it is executed when hovering on a item of my menu.

The reason I need that code is that I'd like to display a description of a [Eclipse Monkey](http://eclipse.org/dash) script when hovering on a menu item in the `Monkey` menu (see [bug #132601](https://bugs.eclipse.org/bugs/show_bug.cgi?id=132601) for a description of this enhancement).

If anyone has an idea, I'd appreciate.


