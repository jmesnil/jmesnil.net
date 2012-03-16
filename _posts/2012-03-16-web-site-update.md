---
layout: post
title: "Web Site Update"
category: 
tags: []
---
{% include JB/setup %}

If you read this post from my Atom feed, it means I migrated successfully my blog from Wordpress to [Jekyll][jekyll].
If you read this from your Web browser, you are seeing the new design for my Web site.

For some time, I wanted to simplify my blog, both its design and the process to write on it.
Wordpress is a great tool to publish on the Web but I wanted to be able to add features myself to better suits my needs.
For example, I want to distinguish between blog posts and links (where I only redirects to interesting contents).

* static generation using [Jekyll][jekyll]
* hosted on [Amazon S3][s3]
* the generated content is upload on Amazon S3 using [S3 tools sync command][s3tools].

I also migrated the [documentation of stomp-websocket][stomp-websocket] to S3.

As far as I can tell, all my contents has been migrated and I kept all URLs compatible with their previous forms.
If you ever find a page wich is not available anymore, please le me know on [Twitter (@jmesnil)][twitter].


[jekyll]: http://jekyllrb.com
[jb]: http://jekyllbootstrap.com/
[s3tools]: http://s3tools.org/s3cmd-sync
[s3]: http://aws.amazon.com/s3/
[twitter]: https://twitter.com/jmesnil
[stomp-websocket]: http://jmesnil.net/stomp-websocket/doc/