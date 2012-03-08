---
date: '2005-01-19 13:53:05'
layout: post
slug: putting-some-order-in-chaotic-wiki
status: publish
title: Putting some order in chaotic wiki
wordpress_id: '69'
tags:
- web
---

By its very own nature, a Wiki is a bazaar and it works great like that. But from time to time, you neet to get some order from that chaos.  


Let take the example of a big corporate wiki with thousand pages and hundred users. Most of the pages are related to a few other pages only and each users modify and read only a few pages.
More than often, the wiki ends up with a lot of related information disseminated on hundred pages with no apparent navigation between them. Given that users deal only with a small subset of this huge wiki, they may not be aware that potential useful information is sitting at other places.






To build some order in this chaos, a very useful feature implemented by most wiki is backlinks. To put it simply, a backlink on a page gives you a list of all the wiki pages pointing to that page thus enabling a backward navigation.  

For example in the [c2 wiki](http://c2.com/cgi/wiki?), every page has a backlink which is the title of the page. If you click on that title, you get a list of all wiki pages which points to that page. Other wikis present that differently (in Twiki, it's a Ref-By link) but most wikis I encountered got that feature.  

You then can use some naming rules. For example you can have (possibly empty) wiki pages whose names ends with Category (e.g. DevelopmentCategory, XmlCategory) and every pages related to that kind of category can add a link to one of these category pages.
E.g. on a page documenting XML binding, I would put a "in XmlCategory" at the beginning of the page to create a link to the XmlCategory page. An user interested to find information about XML has just to use the backlink of the XmlCategory page to find a link to my XML binding page.






Basically with this very simple naming rule, you can categorize your wiki pages so that you can then browse the whole wiki through its backlinks.  

To make it even better, I can create a CategoryCategory page which has a backlink to every other category pages. You have then an entry point to browse all the wiki based on these categories.  



What is great with that approach is that users who write the pages and are the best to categorize it can help other users to find the information very easily.





As an aside, when I wrote this entry, I realized that there is a recurring pattern in the way I want to organize my data. I don't organize my data anymore (a.k.a all in one place and no deep tree structure) but rely more and more on classification with tags, labels, categories to find it. This behavior is occuring with my mails, bookmarks, wiki pages, pictures,... But more about that in another post.
