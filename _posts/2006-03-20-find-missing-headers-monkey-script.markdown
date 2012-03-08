---
date: '2006-03-20 18:32:26'
layout: post
slug: find-missing-headers-monkey-script
status: publish
title: "'Find Missing Headers' Monkey Script"
wordpress_id: '126'
tags:
- eclipse
---

Still playing with [Eclipse Monkey](http://eclipse.org/dash).

I wrote this simple script based on the `org.eclipse.dash.doms` `resources` DOM. It looks for Java files
to find the files which are missing copyright headers.
In my script it is looking for the Eclipse Foundation copyright (`Copyright (c) 2005 Eclipse Foundation`).

{% highlight js %}
--- Came wiffling through the eclipsey wood ---
  /*
   * Menu: Find Missing Headers
   * Kudos: Jeff Mesnil
   *  License: EPL 1.0
   * DOM: http://download.eclipse.org/technology/dash/update/org.eclipse.dash.doms
   */
    
  function main() {
    var files = resources.filesMatching(".*\\.java");
    var match;
    for each( file in files ) { 
      file.removeMyTasks(  );
      if (!file.lines[1].string.match(/\* Copyright \(c\) 2005 Eclipse Foundation/)) {
           file.lines[1].addMyTask(file);
      }
    }
      window.getActivePage().showView("org.eclipse.ui.views.TaskList");
  }

--- And burbled as it ran! ---
{% endhighlight %}

If I run it on my workspace with the imported `org.eclipse.eclipsemonkey` plug-in, it shows that one
file is missing the copyright header:

![Java Files missing copyright headers]({{ site.s3.url}}/images/missing_headers.png "Java Files missing copyright headers")

