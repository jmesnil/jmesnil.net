---
layout: post
title: "TextMate Snippets for Footnotes and Responsive Images"
date: '2013-02-09 13:23:41'
category: 
tags: []
---

I use [TextMate][textmate] to write posts on my website and I have some handy snippets to write footnotes and retina-ready responsive images

## Footnotes

To include a footnote link<a id="fnr1-2013-02-09" href="#fn1-2013-02-09"><sup>1</sup></a>, I have created a snippet triggered by `fn`:

<pre><code class="xml">&lt;a id="fnr${1:1}-`date +"%Y-%m-%d"`" href="#fn${1}-`date +"%Y-%m-%d"`">&lt;sup>${1}&lt;/sup>&lt;/a>
</code></pre>

The current date is automatically inserted and the footnote number starts at `1` and can be edited if there are multiple footnotes in the same post.

Then, to write the footnote (at the end of the post below a horizontal rule), I use a second snippet tiggered by `fnr` (for <u>f</u>oot<u>n</u>ote <u>r</u>eturn):

<pre><code class="xml">1. &lt;a id="fn${1:1}-`date +"%Y-%m-%d"`">&lt;/a> $0&nbsp;&lt;a href="#fnr${1:1}-`date +"%Y-%m-%d"`">&amp;#8617;&lt;/a>
</code></pre>

This automatically creates an ordered list item (the footnote starts with `1.` using the Markdown syntax) with a backlink to the location of the footnote reference. The footnote number can also be edited and starts at `1`. The cursor is then placed to write the footnote text.

## Retina-ready Responsive Images

To display a retina-ready responsive images, I use 8 JPEG files of the same images at different resolutions and [picturefill][picturefill] to display the appropriate one.

To simplify the typing, I have a snippet triggered by `rrf` (for <u>r</u>etina <u>r</u>esponsive <u>f</u>igure):

<pre><code class="xml">&lt;figure>&lt;div class="img" data-picture data-alt="${2:title}">
&lt;div data-src="\#{ site.img_base_url }images/${1:filename}-320w.jpg">&lt;/div>
&lt;div data-src="\#{ site.img_base_url }images/${1:filename}-480w.jpg" data-media="(min-width: 320px)">&lt;/div>
&lt;div data-src="\#{ site.img_base_url }images/${1:filename}-768w.jpg" data-media="(min-width: 480px)">&lt;/div>
&lt;div data-src="\#{ site.img_base_url }images/${1:filename}-900w.jpg" data-media="(min-width: 768px)">&lt;/div>
&lt;div data-src="\#{ site.img_base_url }images/${1:filename}-640w.jpg" data-media="(-webkit-min-device-pixel-ratio: 1.5),(-moz-min-device-pixel-ratio: 1.5),(-o-min-device-pixel-ratio: 3/2)">&lt;/div>
&lt;div data-src="\#{ site.img_base_url }images/${1:filename}-960w.jpg" data-media="(min-width: 320px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 320px) and (-o-min-device-pixel-ratio: 3/2)">&lt;/div>
&lt;div data-src="\#{ site.img_base_url }images/${1:filename}-1536w.jpg" data-media="(min-width: 480px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 480px) and (-o-min-device-pixel-ratio: 3/2)">&lt;/div>
&lt;div data-src="\#{ site.img_base_url }images/${1:filename}.jpg" data-media="(min-width: 768px) and (-webkit-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-moz-min-device-pixel-ratio: 1.5),(min-width: 768px) and (-o-min-device-pixel-ratio: 3/2)">&lt;/div>
&lt;!-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. -->
&lt;noscript>
&lt;img src="\#{ site.img_base_url }images/${1:filename}-900w.jpg" alt="${2:title}">
&lt;/noscript>
&lt;/div>
&lt;figcaption>${2:title} &amp;copy; \#{ site.author.name }&lt;/figcaption>
&lt;/figure>
$0
</code></pre>

The cursor is first placed to edit the `filename` variable which updates the 8 file names (I use consistent suffixes for each resolution) and then for the image `title` variable  (the `\#{ site.img_base_url }` and `\#{ site.author.name }` variables are used by Awestruct when it renders the HTML).

These simple snippets makes it handy to include footnotes or images without writing tedious HTML elements.

---

1. <a id="fn1-2013-02-09"></a>Such as this one...&nbsp;<a href="#fnr1-2013-02-09">&#8617;</a>

[textmate]: http://macromates.com
[picturefill]: https://github.com/scottjehl/picturefill