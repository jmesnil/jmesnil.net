---
layout: post
title: "Web Site Update"
category: 
tags: []
---

If you read this post from my Atom feed, it means I migrated successfully my blog from [Wordpress][wp] to [Jekyll][jekyll].  
If you read this from your Web browser, you are seeing the new design for my [Web site][jmesnil].

For some time, I wanted to simplify my blog, both its design and the process to write on it.
Wordpress is a great tool to publish on the Web but I wanted something simpler to understand and develop new features for.

For example, I want to distinguish between blog posts (prefixing by a {{ site.linked_list.post }} in the title) and links (suffixed by a {{ site.linked_list.link }}) which mainly redirect to interesting content.
There is a Wordpress plug-in for that but I had problems with it every time I upgraded Wordpress. I replaced this plug-in by writing a few lines using [Liquid][liquid] in Jekyll templates.  
Using static pages only also means that I no longer have any cache issues, Web servers are pretty good at serving static content these days :)

This considerably simplify writing content and updating the web site:

* write a post in a text editor using markdown syntax
* generate static files using [Jekyll][jekyll]
* upload the files to [Amazon S3][s3] using [S3 tools sync command][s3tools].

I also took the opportunity to update the design and layout of the Web pages and I owe much to [Mark Reid][mreid] and [James Duncan Davidson][dd] Web sites. Everything that looks great on my site is thanks to them, the rest is my own little contribution.

I also migrated the [documentation of stomp-websocket][stomp-websocket] to S3.

As far as I can tell, all my contents has been migrated and I kept all URLs compatible with their previous forms.
If you ever find a page wich is not available anymore, please le me know on [Twitter (@jmesnil)][twitter].

[jmesnil]: http://jmesnil.net/
[mreid]: http://mark.reid.name/
[dd]: http://duncandavidson.com/
[liquid]: https://github.com/shopify/liquid/wiki/liquid-for-designers
[wp]: http://wordpress.org/
[jekyll]: http://jekyllrb.com
[jb]: http://jekyllbootstrap.com/
[s3tools]: http://s3tools.org/s3cmd-sync
[s3]: http://aws.amazon.com/s3/
[twitter]: https://twitter.com/jmesnil
[stomp-websocket]: http://jmesnil.net/stomp-websocket/doc/