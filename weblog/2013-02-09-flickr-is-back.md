---
layout: post
title: "Flickr Is Back"
date: '2013-02-09 16:37:52'
category: 
tags: []
link: http://www.wired.com/gadgetlab/2013/02/the-return-of-flickr/
---

I like [Flickr][flickr] and used it extensively a few years ago, paying for its unlimited storage and full resolution uploads. However, it stagnated and I left it (like many). 

> But something funny happened. Our photography needs are growing ever more complex — what do we do with all these high-resolution photos we’ve snapped? 

These days, I store my images in a [Amazon S3][s3] bucket. To display retina-ready responsive images on my website, I need 8 JPEG files of the same image at various resolutions. This is something that Flickr had from day one: for every uploaded photo, it provides many files at different resolution (and cropping).

This is a great service that Flick could provide: you upload one photo and Flickr provides all the wizardry (JPEG files, JavaScript + CSS, CDN to reduce the latency) to embed a retina-ready responsive image that adapts from the tiniest of the mobile phone to the largest display monitor. 

I am sure many enthusiast photographers would pay for such a service (and full resolution upload, unlimited storage, analytics, etc. that they already provide).

It's great that Yahoo! is investing on Flickr and I will be happy to see it rise again at the top of the photo websites.

[s3]: http://aws.amazon.com/s3/
[flickr]: http://www.flickr.com