---
date: '2004-11-26 11:36:19'
layout: post
slug: more-on-logging
status: publish
title: More on logging
wordpress_id: '50'
tags:
- java
---

I had two interesting comments on my blog concerning [logging](http://www.jmesnil.net/weblog/2004/11/dos-and-donts-of-logging.html).





[BlogicBlogger](http://blogicblog.blogspot.com/) added [some advices](http://blogicblog.blogspot.com/2004/11/link-dos-and-donts-of-logging.html) to my list. He especially emphasizes the need to uniquely identify the logs (with session Id, transaction Id,...). If you log a multithreaded application, you need more contextual information than in a single user application because same parts of the code can be executed by different threads on behalf of different users and the logs are of no use if you can't follow the flow of execution for a given user ("user" may not be the appropriate term, e.g. it could also be a transaction). 





Scott Deboy proposed me to use [Chainsaw](http://logging.apache.org/log4j/docs/chainsaw.html) to watch the log files. I was aware of the product but I need to check that it can be used with an inconsistent log format (those dreaded `System.err.print()` are mixed in the log4j files).





I saw a lot of documentation on logs but I find surprising that there is not so much good documentation on the specificity of logging multithreaded applications.
