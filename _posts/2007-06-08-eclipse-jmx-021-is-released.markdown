---
date: '2007-06-08 10:25:09'
layout: post
slug: eclipse-jmx-021-is-released
status: publish
title: ⚑ eclipse-jmx 0 .2.1 is released
wordpress_id: '154'
tags:
- eclipe-jmx
- java
- jmx
---

[eclipse-jmx 0.2.1][e-jmx] has been released.

Compared to previous release, the main new feature is the support for MBean notifications.

Under the hood, the code which displays MBean attribute values has been completely rewritten by Ben Walstrum using extension points.
Thanks to his contribution, any MBean attribute display can now be customized (e.g. using charts, hyperlinks, ...)

See [what's new & noteworthy][nw] and the [release notes][rn].  
You can [download it][zip] or update it from Eclipse using the [update site][update-site]. 

As usual, one word of caution: it is still in alpha stage and nowhere near as functional or usable as [jconsole][jconsole].

Do not hesitate to send feedback on the [dev mailing list][dev-ml] or to create issues in its [tracker][tracker] if you encounter a bug.

Enjoy! 

[e-jmx]: http://code.google.com/p/eclipse-jmx/ 
[rn]: http://code.google.com/p/eclipse-jmx/wiki/ReleaseNotes_0_2_1 
[nw]: http://code.google.com/p/eclipse-jmx/wiki/NewAndNoteworthy_0_2_1 
[zip]: http://eclipse-jmx.googlecode.com/files/eclipse-jmx_0.2.1.zip 
[update-site]: http://eclipse-jmx.googlecode.com/svn/trunk/net.jmesnil.jmx.update/
[jconsole]: http://java.sun.com/j2se/1.5.0/docs/guide/management/jconsole.html
[dev-ml]: http://groups.google.com/group/eclipse-jmx-dev
[tracker]: http://code.google.com/p/eclipse-jmx/issues/list
