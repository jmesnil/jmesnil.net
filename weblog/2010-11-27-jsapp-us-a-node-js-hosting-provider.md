---
date: '2010-11-27 00:56:29'
layout: post
slug: jsapp-us-a-node-js-hosting-provider
status: publish
title: 'JSApp.US: a node.js Hosting Provider'
link: http://jsapp.us/
wordpress_id: '1414'
tags:
- javascript
- web
---

I was looking for a provider to host the HTML5 / [node.js][nodejs] Web application that I am blogging about [here][post1] and [there][post2] and [JSApp.US][jsapp] is the first one that I found.

It is straightforward to use and I have deployed my Web application on it. You can try it by yourself on your iPhone or iPad by going to [http://board.jsapp.us/](http://board.jsapp.us/).

At first, it complained that `__dirname` was not defined when `server.js` is trying to read files based on the URL path.
I modified `server.js` to remove the leading `/` from the path and it works fine:

<pre><code class='javascript'>    // won't work on JSApp.us
    fs.readFile(__dirname + path, function(err, data) {
       ...
    }
    // but this works
    fs.readFile(path.substring(1, path.length), function(err, data) {
       ...
    }
</code></pre>



The offline support does not work: somehow this provider does not return the `Content-Type` HTTP header set by `server.js`.
Since the cache manifest is not served with the expected `text/cache-manifest`, I suppose that Safari does not take it into account and bypass the offline configuration.  

__update:__ I was wrong the `cache.manifest` file is returned with the correct `Content-Type`:


    
    
    $ curl -Gi http://board.jsapp.us/cache.manifest
    HTTP/1.1 200 OK
    Server: nginx/0.8.53
    Date: Sat, 27 Nov 2010 00:06:45 GMT
    Content-Type: text/cache-manifest
    Transfer-Encoding: chunked
    Connection: keep-alive
    
    CACHE MANIFEST
    # 2010-11-27
    
    CACHE:
    /screen.css
    /client.js
    /jquery.min.js
    



I don't know why offline support is not working...
The rest of the application seems to work fine though.  

It will make the next version of the application more interesting. I want to add Web Sockets support to display the pieces of the other users on the Web application (in addition to its own piece).
With this hosting provider, I'll be able to release a version that everyone will be able to try.

As an aside, it uses [SkyWriter][skywriter] (n&eacute; Bespin) to edit the code and the integration is pretty slick. 

[nodejs]: http://nodejs.org/
[post1]: /weblog/2010/11/24/html5-web-application-for-iphone-and-ipad-with-node-js/
[post2]: /weblog/2010/11/26/offline-support-and-standalone-mode-for-html5-web-application/
[jsapp]: http://jsapp.us/
[skywriter]: https://mozillalabs.com/skywriter/
