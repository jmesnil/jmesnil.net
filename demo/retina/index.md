---
layout: page
title: "Serving Retina Images"
date: '2013-01-23 12:00:58'
category:
tags: []
---

<figure><div class="img" data-picture data-alt="Wedding Pictures at Le Louvre, Paris">
<div data-src="images/2012-09-20-Louvre-320w.jpg"></div>
<div data-src="images/2012-09-20-Louvre-480w.jpg" data-media="(min-width: 320px)"></div>
<div data-src="images/2012-09-20-Louvre-768w.jpg" data-media="(min-width: 480px)"></div>
<div data-src="images/2012-09-20-Louvre-900w.jpg" data-media="(min-width: 768px)"></div>
<div data-src="images/2012-09-20-Louvre-640w.jpg" data-media="(-webkit-min-device-pixel-ratio: 1.5),(-moz-min-device-pixel-ratio: 1.5),(-o-min-device-pixel-ratio: 3/2)"></div>
<div data-src="images/2012-09-20-Louvre-960w.jpg" data-media="(min-width: 320px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-o-min-device-pixel-ratio: 3/2)"></div>
<div data-src="images/2012-09-20-Louvre-1536w.jpg" data-media="(min-width: 480px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-o-min-device-pixel-ratio: 3/2)"></div>
<div data-src="images/2012-09-20-Louvre.jpg" data-media="(min-width: 768px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-o-min-device-pixel-ratio: 3/2)"></div>
<!-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. -->
<noscript>
<img src="images/2012-09-20-Louvre-900w.jpg" alt="Wedding Pictures at Le Louvre, Paris">
</noscript>
</div>
<figcaption>Wedding Pictures at Le Louvre, Paris &copy; Jeff Mesnil</figcaption>
</figure>

<figure>
<picture>
	<!--[if IE 9]><video style="display: none;"><![endif]-->
	<source srcset="images/2012-09-20-Louvre-900w.jpg, images/2012-09-20-Louvre.jpg 2x" media="(min-width:768px)">
	<source srcset="images/2012-09-20-Louvre-480w.jpg, images/2012-09-20-Louvre-960w.jpg 2x">
	<!--[if IE 9]></video><![endif]-->
	<img srcset="images/2012-09-20-Louvre-480w.jpg, images/2012-09-20-Louvre-960w.jpg 2x" alt="Wedding Pictures at Le Louvre, Paris">
</picture>
<noscript>
<img src="images/2012-09-20-Louvre-480w.jpg" alt="Wedding Pictures at Le Louvre, Paris">
</noscript>
<figcaption>Wedding Pictures at Le Louvre, Paris
  <span class="copyright">&copy;&nbsp;#{ site.author.name.sub " ", "&nbsp;" }</span>
</figcaption>
</figure>
</div>