---
date: '2006-04-18 21:25:35'
layout: post
slug: stop-event-propagation-in-eclipse
status: publish
title: How to stop SWT Control traversal action
wordpress_id: '133'
tags:
- eclipse
---

Another ah-ha moment with [Eclipse](http://eclipse.org/)...

It is quite simple but I stumble upon it before finding how in Eclipse you can stop the traversal of SWT `Control` from a `TraverseListener` implementation.

In your listener, handle the `TraverseEvent` event and then just

    event.doit = false;

and the system will stop traversing the Controls.

Everything is well explained in [TraverseEvent javadoc](http://help.eclipse.org/help31/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/swt/events/TraverseEvent.html) (but I'm guilty of not reading javadoc until I need it...). The explanation is worth a read and shows how powerful traversal can be in eclipse using both `TraverseEvent` `detail` and `doit` fields. 

