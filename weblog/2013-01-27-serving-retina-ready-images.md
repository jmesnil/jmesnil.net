---
layout: post
title: "Serving Retina-Ready Images"
date: '2013-01-27 13:29:46'
category: 
tags: []
---

I have recently bought a refurbished 15" Retina MacBook Pro. The display is stunning and it is a pleasure to edit and view photos on it.

I took the opportunity to redesign my Web site to display images at the most favorable resolution using [picturefill][picturefill] and make it more responsive so that it displays at an appropriate size on phones and tablets.

<figure>
<picture>
  <!--[if IE 9]><video style="display: none;"><![endif]-->
  <source srcset="#{ site.img_base_url }images/2012-09-20-Louvre-900w.jpg, #{ site.img_base_url }images/2012-09-20-Louvre.jpg 2x" media="(min-width: 768px)">
  <source srcset="#{ site.img_base_url }images/2012-09-20-Louvre-480w.jpg, #{ site.img_base_url }images/2012-09-20-Louvre-960w.jpg 2x"> 
  <!--[if IE 9]></video><![endif]--> 
  <img srcset="#{ site.img_base_url }images/2012-09-20-Louvre-480w.jpg, #{ site.img_base_url }images/2012-09-20-Louvre-960w.jpg 2x" alt="Wedding Photos at Le Louvre, Paris">
</picture>
<noscript>
  <img src="#{ site.img_base_url }images/2012-09-20-Louvre-480w.jpg" alt="Wedding Photos at Le Louvre, Paris">
</noscript>
<figcaption>Wedding Photos at Le Louvre, Paris
  <span class="copyright">&copy;&nbsp;#{ site.author.name.sub " ", "&nbsp;" }</span>
</figcaption>
</figure>

I did not update older photos but starting from now, I'll provide responsive images. Using multiple export settings in Lightroom and a TextMate snippet to generate the corresponding HTML code does not weighten my workflow too much.

[picturefill]: https://github.com/scottjehl/picturefill