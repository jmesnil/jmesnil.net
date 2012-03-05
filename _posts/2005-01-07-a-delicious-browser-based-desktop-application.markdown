---
date: '2005-01-07 22:36:50'
layout: post
slug: a-delicious-browser-based-desktop-application
status: publish
title: ⚑ A del.ici.ous browser-based desktop application
wordpress_id: '72'
tags:
- osgi
- web
---

Following my last post on [browser-based desktop applications](http://www.jmesnil.net/weblog/2005/01/new-breed-of-applications-browser.html), I prototyped a little application to play with these ideas.




I'm a big fan of the social bookmarks manager [del.icio.us](http://del.icio.us) which enable you to bookmark urls and categorize them. However, all your bookmarks are available to everyone else (it manages _social_ bookmarks after all). 
But, from time to time, I also need to bookmark urls that I don't want to share (e.g. private ones or professional ones which could give too much hints to competitors).  

So I bookmark these URLs with my browser. But they can not be categorized like del.icio.us ones (folders don't help). So when I want to check bookmarks for a given topic I've to look in two different places and interfaces (the web bookmarks toolbar and del.icio.us).

I prototyped a simple application with the following requirements:



  
  * keep a private list of bookmarks

  
  * categorize them like in del.icio.us

  
  * aggregate private and del.icio.us bookmarks

  
  * display them in the same interface

  
  * search categories for both private and del.icio.us bookmarks





The prototype is a browser-based desktop application (i.e. a standalone application which runs its embedded HTTP server and is displayed in the browser).  

The application keeps a list of private bookmarks and aggregates them with del.icio.us ones (retrieved with [del.icio.us REST API](http://del.icio.us/doc/api) thanks to the [delicious-java](http://delicious-java.sf.net) library).
In fact, from the user interface, it is quite similar to del.icio.us interface.
The only differences is that private bookmarks are automatically categorized with a `private` tag. (As an aside, I first had two type of bookmarks: public and private ones. But as I coded, I realized that I could used the bookmark own tags to categorize them as public or private...).  

Special urls (like for displaying bookmarks for a set of categories) redirect to the application which filters both del.icio.us and private bookmarks.





Here some screenshots (I haven't care much for the layout  but it is based on del.icio.us):





[![del1](http://photos1.flickr.com/3145428_9c267d3cc8_m.jpg)](http://photos1.flickr.com/3145428_9c267d3cc8_o.jpg)  

To save a bookmark, type its url, its description, its (optional) extended description and list of space-separated tags.
To save it in the application ( i.e. on your desktop), tag it as `private`. Otherwise, the bookmark will be saved on del.icio.us.





[![del2](http://photos2.flickr.com/3145426_d3dcd4f44f_t.jpg)](http://photos2.flickr.com/3145426_d3dcd4f44f_o.jpg)  

If I look for all the bookmarks with the `osgi` tags, I see that some of them are categorized as `private`. They're stored on the application and not on del.icio.us (see my [del.icio.us OSGi page](http://del.icio.us/jmesnil/osgi) to see the differences).  

As you can see on the screenshots, the only differences is that private bookmarks are categorized with a `private` tag.






I haven't reproduced all features provided by del.icio.us but this first prototype is functional enough to help me vizualize what browser-based desktop applications could be.  

I see this prototype like the equivalent of [Google Desktop Search](http://desktop.google.com/) but for bookmarks. Both application aggregates local and web data and displays them in a consistent way in the browser.





As for the technology I used, it's based on the [OSGi framework](http://www.osgi.org/) and its HTTP service (I used [Knoplferfish](http://www.knopflersfish.org) implementation). The cool thing is that everything can be delivered as a standalone application that sits anywhere on your hard drive. You just start it and point your web browser to http://localhost:8080:<your del.icio.us name>. It's also possible make it a Windows or Mac OS X service with a cute little icon in the tray.  

And, being based on OSGI, you can also use it from your PocketPC!  




One other cool feature of this application is that since it sits on your own machine, you can also bookmark local files and categorize them.  

For example, I've a local version of the OSGi specification in PDF file. I bookmarked it with my application with the url file:///Users/jeff/doc/...../r3.book.pdf.
So when I want to see all my bookmarks related to OSGi (http://localhost:8080/jmesnil?tag=osgi), I've got both web url and local documentation (URLs starting with `file://` are automatically tagged as `private` and `local`).  

[![del3](http://photos2.flickr.com/3145427_318403b1c0_t.jpg)](http://photos2.flickr.com/3145427_318403b1c0_o.jpg)  

The only problem is that you can't open the files from their URLs (I already [blogged about it](http://www.jmesnil.net/weblog/2005/01/accepting-file-url-from-localhost-http.html) but I haven't find a correct solution yet).




There is nothing rocket science in this prototype but there is some potential for such browser-based desktop applications to integrate in a consistent way desktop data with the whole web.
