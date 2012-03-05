---
date: '2010-11-26 21:54:28'
layout: post
slug: offline-support-and-standalone-mode-for-html5-web-application
status: publish
title: '⚑ Offline Support and Standalone Mode for HTML5 Web Application '
wordpress_id: '1376'
tags:
- iphone
- javascript
- web
---

Let's continue working on the HTML5 Web Application for the iPhone with node.js

[Last time][first-post], I created the first version of the Web application to move a piece when the user moves the iPhone and coded a simple Web server on top of node.js.

The Web application works fine but it is not pretty and there are a few things we can improve.
Before looking at Web Sockets and other fancy code, let's make the Web application prettier.

## iPhone Standalone Web Application

The major annoyance is that Safari chrome takes a lot of space and hides the bottom of the board:

<img src="http://jmesnil.net/weblog/wp-content/uploads/2010/11/chrome.png" alt="" title="chrome" width="320" height="155" class="aligncenter size-full wp-image-1383" />

To display a Web application without Safari chrome, we can make it a [standalone Web application][standalone].

In `index.html`, we add some `<meta>` information to the `<head>` part:

{% highlight html %}
<head>
  ...
  <meta name="viewport" content="width=device-width, user-scalable=0" />
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
</head>
{% endhighlight %}

The [`viewport`][viewport] meta ensures that the Web page will be sized to the device width and prevents the user to change the page scale (by pinching it).  

The [`apple-mobile-web-app-capable`][standalone] will launch the Web application in full-screen mode (without Safari chrome) to look like a native application. The Web application must be added to the iPhone home screen and start from there to appear in full-screen mode.

Last thing is to render the iPhone status bar in black by setting the [`apple-mobile-web-app-status-bar-style`][status-bar] to black.

With these 3 meta information, the Web application looks better and display the whole board

<img src="http://jmesnil.net/weblog/wp-content/uploads/2010/11/Board-2nd-version.jpg" alt="" title="Board - 2nd version" width="320" height="480" class="aligncenter size-full wp-image-1380" />

## Offline Support

At the moment, node.js serves only static pages. When the iPhone has loaded the Web application, it no longer connects to the Web server.

Let's add offline support so that we can run the Web application even when the server is down (or unreachable).

HTML5 supports [offline][offline] applications through the cache manifest. The best introduction on the subject is the [Offline chapter in Dive into HTML5][offline-dip].

For this Web application this means that we must write a `cache.manifest` file:

{% highlight manifest %}
CACHE MANIFEST

CACHE:
/screen.css
/client.js
/jquery.min.js
{% endhighlight %}

This cache manifest tells the Web browsers to call all these files to run the Web application offline.

This cache manifest must be declared in the entry point of the Web application (`index.html` in this case) with the `manifest` attribute of the `html` element:

{% highlight html %}
<!doctype html>
<html manifest="/cache.manifest">
...
{% endhighlight %}

Finally, we need to update `server.js` to send the `cache.manifest` file with the correct HTTP `Content-Type`.
Only the `getContentType()`function needs to be modified:

{% highlight js %}
function contentType(path) {
   if (path.match('.js$')) {
      return "text/javascript";
   } else if (path.match('.css$')) {
      return  "text/css";           
   } else if (path.match('.manifest$')) {
      return  "text/cache-manifest";
   }  else {
      return "text/html";
   }
}
{% endhighlight %}

With this modification, `cache.manifest` will be sent to the Web browser with the correct `text/cache-manifest` Content-Type.

We must restart the server to take into account the `server.js` modification:

{% highlight bash%}
$ node.js server.js
HTTP server running at htpp://0.0.0.0:8080
{% endhighlight %}

I can then reload the Web application and add it to the iPhone home screen.
With offline support, I will be able to use the Web application even if the server is not running or unreachable.

Here is a small video of the result with the updated Web application:

<object width="640" height="385"><param name="movie" value="http://www.youtube.com/v/yoJAC2Qc0uo?fs=1&amp;hl=fr_FR&amp;rel=0&amp;hd=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/yoJAC2Qc0uo?fs=1&amp;hl=fr_FR&amp;rel=0&amp;hd=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="385"></embed></object>

Note the black status bar and the full screen mode after I started the Web application from the iPhone home screen. It is indistinguishable from a native application but runs on the Web (it’s not obvious from the video but the camera was recording from above: the iPhone was held horizontally)


## Source Code

I have pushed the application on [Github][board-git]. You can clone it with Git:

{% highlight bash%}
git clone git://github.com/jmesnil/board-node.git
{% endhighlight %}

## Conclusion

By adding a few `meta` information to the Web application, it is possible to make it look better integrated to the iPhone.  
Offline support is trickier than this simple example make it look like but it gives the right idea to start dealing with it.    

Next step is to add Web Sockets support to the node.js to display the moving pieces of _other users_ on the Web application.

## Further Reading

* [Safari Web Content Guide][safari]
* [HTML5 Offline Web applications][offline] (and its corresponding ["Dive into HTML5" chapter][offline-dip])

[first-post]: http://jmesnil.net/weblog/2010/11/24/html5-web-application-for-iphone-and-ipad-with-node-js/
[standalone]: http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html%23//apple_ref/doc/uid/TP40002051-CH3-SW2
[status-bar]: http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html%23//apple_ref/doc/uid/TP40002051-CH3-SW1
[viewport]: http://developer.apple.com/library/safari/documentation/AppleApplications/Reference/SafariWebContent/UsingtheViewport/UsingtheViewport.html#//apple_ref/doc/uid/TP40006509-SW1
[offline]: http://www.whatwg.org/specs/web-apps/current-work/multipage/offline.html
[offline-dip]: http://diveintohtml5.org/offline.html
[safari]: http://developer.apple.com/library/safari/#documentation/AppleApplications/Reference/SafariWebContent/Introduction/Introduction.html
[board-git]: http://github.com/jmesnil/board-node
