---
layout: page
title: "Style Demo"
date: '2013-01-23 12:00:58'
category:
tags: []
---

# Typography

# Header 1

## Header 2

### Header 3

#### Header 4


Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer blandit ex vel dui sodales lacinia. Pellentesque mollis augue a augue porttitor, ut pulvinar eros malesuada. Vivamus non hendrerit leo, blandit cursus dolor. Integer lobortis, velit malesuada eleifend scelerisque, magna augue sollicitudin eros, vitae viverra est libero a dui. Aenean augue turpis, luctus eu enim nec, sagittis condimentum massa. Cras facilisis, odio sed tristique fringilla, enim nibh finibus eros, vitae maximus augue eros eu nisl. Etiam diam felis, semper a nibh quis, laoreet tempus eros. Mauris congue dolor nec condimentum posuere. Praesent mattis magna eu dignissim imperdiet. Nam eu mauris accumsan, condimentum mauris sit amet, vehicula neque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In non tellus eu ipsum commodo convallis. Quisque orci lorem, imperdiet sed orci vitae, facilisis tristique lorem. Curabitur non iaculis lorem.

italic: _Lorem ipsum dolor sit amet,_  
bold: __Integer blandit ex vel dui sodales__  
code: `Lorem ipsum dolor sit amet`

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer blandit ex vel dui sodales lacinia. Pellentesque mollis augue a augue porttitor, ut pulvinar eros malesuada. Vivamus non hendrerit leo, blandit cursus dolor. Integer lobortis, velit malesuada eleifend scelerisque, magna augue sollicitudin eros, vitae viverra est libero a dui. Aenean augue turpis, luctus eu enim nec, sagittis condimentum massa. Cras facilisis, odio sed tristique fringilla, enim nibh finibus eros, vitae maximus augue eros eu nisl. Etiam diam felis, semper a nibh quis, laoreet tempus eros. Mauris congue dolor nec condimentum posuere. Praesent mattis magna eu dignissim imperdiet. Nam eu mauris accumsan, condimentum mauris sit amet, vehicula neque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In non tellus eu ipsum commodo convallis. Quisque orci lorem, imperdiet sed orci vitae, facilisis tristique lorem. Curabitur non iaculis lorem.
> 
> — Famous Latin Author

[Mobile & Web Messaging](http://mobile-web-messaging.net)

* item 1
* item 2
  * item 2.1
  * item 2.2
* item 3

test

1. step 1
1. step 2
   1. step 2.1
   1. step 2.2
1. step 3

# Code

<pre><code class='javascript'>var Stomp = require('stompjs');

// Use raw TCP sockets
var client = Stomp.overTCP('localhost', 61613);
// uncomment to print out the STOMP frames
// client.debug = console.log;

client.connect('user', 'password', function(frame) {
  console.log('connected to Stomp');

  client.subscribe('/queue/myqueue', function(message) {
    console.log("received message " + message.body);

    // once we get a message, the client disconnects
    client.disconnect();
  });
  
  console.log ('sending a message');
  client.send('/queue/myqueue', {}, 'Hello, node.js!');
});
</code></pre>

# Figure

<figure>
<picture>
  <!--[if IE 9]><video style="display: none;"><![endif]-->
  <source srcset="#{ site.img_base_url }images/2014-05-02-Rainy+Venezia-900w.jpg, #{ site.img_base_url }images/2014-05-02-Rainy+Venezia-1800w.jpg 2x" media="(min-width: 768px)">
  <source srcset="#{ site.img_base_url }images/2014-05-02-Rainy+Venezia-480w.jpg, #{ site.img_base_url }images/2014-05-02-Rainy+Venezia-960w.jpg 2x"> 
  <!--[if IE 9]></video><![endif]--> 
  <img srcset="#{ site.img_base_url }images/2014-05-02-Rainy+Venezia-480w.jpg, #{ site.img_base_url }images/2014-05-02-Rainy+Venezia-960w.jpg 2x" alt="Rainy Venezia">
</picture>
<noscript>
  <img src="#{ site.img_base_url }images/2014-05-02-Rainy+Venezia-480w.jpg" alt="Rainy Venezia">
</noscript>
<figcaption>Rainy Venezia
  <span class="copyright">&copy;&nbsp;#{ site.author.name.sub " ", "&nbsp;" }</span>
</figcaption>
<div class="metadata">
  <i class="fa fa-camera"></i>&nbsp;Fuji&nbsp;X-E2
  <span class="speed">1/100</span>
  <span class="aperture"><i>&#402;</i>/9</span>
  <span class="iso">ISO&nbsp;1000</span>
  <span class="focal-length">55&nbsp;mm</span>
</div>
</figure>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer blandit ex vel dui sodales lacinia. Pellentesque mollis augue a augue porttitor, ut pulvinar eros malesuada. Vivamus non hendrerit leo, blandit cursus dolor. Integer lobortis, velit malesuada eleifend scelerisque, magna augue sollicitudin eros, vitae viverra est libero a dui. Aenean augue turpis, luctus eu enim nec, sagittis condimentum massa.

<figure class="portrait">
<picture>
  <!--[if IE 9]><video style="display: none;"><![endif]-->
  <source srcset="#{ site.img_base_url }images/2014-11-15-JFM07918-900w.jpg, #{ site.img_base_url }images/2014-11-15-JFM07918-1800w.jpg 2x" media="(min-width: 768px)">
  <source srcset="#{ site.img_base_url }images/2014-11-15-JFM07918-480w.jpg, #{ site.img_base_url }images/2014-11-15-JFM07918-960w.jpg 2x"> 
  <!--[if IE 9]></video><![endif]--> 
  <img srcset="#{ site.img_base_url }images/2014-11-15-JFM07918-480w.jpg, #{ site.img_base_url }images/2014-11-15-JFM07918-960w.jpg 2x" alt="Marion &amp; Rapha&euml;l">
</picture>
<noscript>
  <img src="#{ site.img_base_url }images/2014-11-15-JFM07918-480w.jpg" alt="Marion &amp; Rapha&euml;l">
</noscript>
<figcaption>Marion &amp; Rapha&euml;l
  <span class="copyright">&copy;&nbsp;#{ site.author.name.sub " ", "&nbsp;" }</span>
</figcaption>
<div class="metadata">
  <i class="fa fa-camera"></i>&nbsp;Fuji&nbsp;X-E2
  <span class="speed">1/180</span>
  <span class="aperture"><i>&#402;</i>/5.6</span>
  <span class="iso">ISO&nbsp;400</span>
  <span class="focal-length">56&nbsp;mm</span>
</div>
</figure>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer blandit ex vel dui sodales lacinia. Pellentesque mollis augue a augue porttitor, ut pulvinar eros malesuada. Vivamus non hendrerit leo, blandit cursus dolor. Integer lobortis, velit malesuada eleifend scelerisque, magna augue sollicitudin eros, vitae viverra est libero a dui. Aenean augue turpis, luctus eu enim nec, sagittis condimentum massa.
# Video

<div class="video-wrapper" style="width:800px"><div class="video">
<iframe src="http://player.vimeo.com/video/49544593" width="800" height="450" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>
</div></div>
