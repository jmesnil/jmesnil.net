---
date: '2006-07-03 15:02:20'
layout: post
slug: eclipse-32-and-welcome-page-on-ubuntu
status: publish
title: Eclipse 3.2 and Welcome page on Ubuntu
wordpress_id: '138'
tags:
- eclipse
---

Eclipse 3.2 is out and it is a great release. :-)

However, the default Welcome page I had on my [Ubuntu](http://www.ubuntu.com/) desktop is
quite broken

![Broken Welcome Page in Eclipse 3.2](/img/broken-welcome-3.2.jpg)

* it is ugly
* the links to the workbench are broken (links like http://org.eclipse.ui.intro/showPage?id=overview open in Firefox)
* when I close it, it asks me to save a file

After a little search on eclipe.org [SWT FAQ](http://www.eclipse.org/swt/faq.php#browserlinux),
it appears that by default, Ubuntu is missing the `MOZILLA_FIVE_HOME` which is required by
SWT to use the web browser internally.

I just added this variable before starting Eclipse:

    export MOZILLA_FIVE_HOME=/usr/lib/mozilla-firefox/

and the Welcome page appeared as expected:

![Welcome Page in Eclipse 3.2](/img/welcome-3.2.jpg)

I really like the new theme (Circles) by the way.
)
