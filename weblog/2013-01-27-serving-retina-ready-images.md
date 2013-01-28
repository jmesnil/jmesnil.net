---
layout: post
title: "Serving Retina-Ready Images"
date: '2013-01-27 13:29:46'
category: 
tags: []
---

I have recently bought a refurbished 15" Retina MacBook Pro. The display is stunning and it is a pleasure to edit and view photos on it.

I took the opportunity to redesign my Web site to display images at the most favorable resolution using [picturefill][picturefill] and make it more responsive so that it displays at an appropriate size on phones and tablets.

<figure><div class="img" data-picture data-alt="Wedding Photos at Le Louvre, Paris">
<div data-src="#{ site.img_base_url }images/2012-09-20-Louvre-320w.jpg"></div>
<div data-src="#{ site.img_base_url }images/2012-09-20-Louvre-480w.jpg" data-media="(min-width: 320px)"></div>
<div data-src="#{ site.img_base_url }images/2012-09-20-Louvre-768w.jpg" data-media="(min-width: 480px)"></div>
<div data-src="#{ site.img_base_url }images/2012-09-20-Louvre-900w.jpg" data-media="(min-width: 768px)"></div>
<div data-src="#{ site.img_base_url }images/2012-09-20-Louvre-640w.jpg" data-media="(-webkit-min-device-pixel-ratio: 1.5),(-moz-min-device-pixel-ratio: 1.5),(-o-min-device-pixel-ratio: 3/2)"></div>
<div data-src="#{ site.img_base_url }images/2012-09-20-Louvre-960w.jpg" data-media="(min-width: 320px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-o-min-device-pixel-ratio: 3/2)"></div>
<div data-src="#{ site.img_base_url }images/2012-09-20-Louvre-1536w.jpg" data-media="(min-width: 480px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-o-min-device-pixel-ratio: 3/2)"></div>
<div data-src="#{ site.img_base_url }images/2012-09-20-Louvre.jpg" data-media="(min-width: 768px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-o-min-device-pixel-ratio: 3/2)"></div>
<!-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. -->
<noscript>
<img src="#{ site.img_base_url }images/2012-09-20-Louvre-900w.jpg" alt="Wedding Photos at Le Louvre, Paris">
</noscript>
</div>
<figcaption>Wedding Photos at Le Louvre, Paris &copy; Jeff Mesnil</figcaption>
</figure>

I did not update older photos but starting from now, I'll provide responsive images. Using multiple export settings in Lightroom and a TextMate snippet to generate the corresponding HTML code does not weighten my workflow too much.

[picturefill]: https://github.com/scottjehl/picturefill