---
date: '2005-01-05 16:53:06'
layout: post
slug: a-new-breed-of-applications-browser-based-desktop-applications
status: publish
title: 'A new breed of applications: browser-based desktop applications'
wordpress_id: '74'
tags:
- web
---

<p>There is a lot of talks about <acronym title="Rich Internet Applications">RIA</acronym> since there are web application which require richer widgets than HTML. Some approaches are <a href=""http://www.mozilla.org/projects/xul/>XUL</a>, <a href="http://longhorn.msdn.microsoft.com/lhsdk/core/overviews/about%20xaml.aspx">XAML</a>, <a href="http://www.macromedia.com/go/gnavtray_flex_home">Flex</a>,...</p>

<p>
However I wonder if there won't be an opposite trend of browser-based desktop application, i.e. desktop applications which are used from a web browser.
An example which comes to my mind is <a href="http://desktop.google.com/">Google Desktop Search</a>.<br />
The advantage of such applications is that they could enhance user experience by seemingly integrate local manipulation of data with the whole web.
For example, would it be interesting to have a browser-based application which aggregates your weblog entries, <a href="http://www.google.com/">google</a> searches, <a href="http://del.icio.us/">del.icio.us</a> bookmarks and <a href="http://www.flickr.com/">flickr</a> pictures to provide a web dashboard (or more precisely a local web portal)?
You could then be able to drag and drop a google results link in your del.icio.us bookmarks. Or drag and drop a flickr picture in your weblog. Or drag and drop a picture from <a href="http://www.apple.com/ilife/iphoto/">iPhoto</a> in flickr. Or...</p>
<p>
The application could be based on <a href="http://www.osgi.org">OSGi</a> framework and its embedded servlet container. You have several bundles composed of Servlets for each type of "service" (del.icio.us, blog, flickr) and a dashboard which deals with interactions between the services. Data could be aggregated by REST Web services (either through XmlHttpRequest or HTTP/XML/XSL Java libraries).<br />
Another potential advantage of such an approach is that these local applications could use an intelligent cache (a la <a href="http://www.adambosworth.net/">Adam Bosworth</a>'s Project Alchemy except that this cache is not located within the browser...) which will keep the HTTP requests if you're offline and send them once you are online again.</p>
<p>Does that make sense or is it a crazy stupid thought?</p>