---
date: '2009-08-25 17:31:52'
layout: post
slug: read-lature-a-web-application-to-save-articles-and-read-them-later
status: publish
title: '"Read Lature": A Web Application to Save Articles and Read Them Later'
wordpress_id: '766'
tags:
- java
- misc
- web
---

As an exercice when I learn a new programming language or a new environment, I develop simple applications to get a feel on the language, the platform, its libraries, etc.  When I lack ideas for these applications, I redevelop applications that I use.

In order to learn [Clojure][clojure] and [Google App Engine][appengine], I have developed [Read Lature][readlature], a web application to save articles and read them later (very similar to [Instapaper][instapaper])<a id="fnr1-2009-08-25" href="#fn1-2009-08-25"><sup>1</sup></a>.

The idea is simple: I want to keep reference on articles or blog posts that can be interesting but I don't want or don't have time to read them immediately.
I do not use bookmarks for that (either using my browser bookmarks or [delicious][delicious]): my bookmarks are long-lived while I want to keep a reference to these articles only for a short period (and keeping them open in tabs does not scale).

To save articles, you just need to drag a bookmarklet to your bookmarks bar.
When you find a good article or blog post, you click on the bookmarklet to save it. It will be added to Read Lature so that you can read it when you have some time. Once it is read, it is automatically moved to the archive. Articles can also be _starred_ for further readings.

The second way to save article to Read Lature is to use [Google Reader][reader]. Setup a custom link and you can send articles to Read Lature directly from Google Reader (as explained in the [instructions][gr-instructions]).

I mainly use Read Lature to save articles and read them later on my iPhone when I am away:

<figure style="max-width: 200px">
<img src="#{ site.s3.url}images/2009-08-25-photo-200x300.jpg" alt="Reading from the iPhone" title="Reading from the iPhone" />
</figure>

The application is hosted on Google "Cloud" and leverages Google accounts for  user credentials.  
To try it, go to [Read Lature][readlature], login using your Google (or Gmail) account, and follow the instructions. 

The application is written using Clojure, [Compojure][compojure] and [jQuery][jquery] and is less than 500 SLOC (75% is Clojure code, the rest is JavaScript).  
Read Lature code is released the code under [Apache 2.0 License][apl] on [GitHub][readlature.git].

I will write later a review of  the book ["Progamming Clojure"][prog-clojure], that I have just finished reading, and some thoughts about Clojure base on my experience with it so far.

----

1. <a id="fn1-2009-08-25"></a> So similar in fact that I first named the project _Instapapure_ for "Instapaper in Clojure" but I did not like it and renamed it _Read Lature_ (for "Read Later with Clojure"). Naming projects is a dark art that I do not master...&nbsp;<a href="#fnr1-2009-08-25">&#8617;</a>

[readlature]:      http://readlature.appspot.com
[readlature.git]: http://github.com/jmesnil/readlature/
[apl]:                   http://apache.org/licenses/LICENSE-2.0
[instapaper]:     http://www.instapaper.com/u
[clojure]:            http://clojure.org/
[compojure]:     http://github.com/weavejester/compojure/
[jquery]:             http://jquery.com/
[appengine]:     http://appengine.google.com
[reader]:           http://google.com/reader
[gr-instructions]: http://readlature.appspot.com/public/google-reader.html
[delicious]:        http://delicious.com/
[prog-clojure]: http://www.pragprog.com/titles/shcloj/programming-clojure