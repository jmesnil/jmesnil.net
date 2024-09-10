---
layout: post
title: "20-year anniversary of jmesnil.net"
date: '2024-09-11 12:17:15'
---

I missed the date but I posted [the first article on this blog](/weblog/2004/06/11/distributed-computing-is-not-an-afterthought/) on June, 11th 2024.

Twenty years later, and 350 posts later, my server is still there serving all the content I wrote from the start.

I went through different hosts and visual presentation until I settled down with using a AWS S3 Buck to host this static server built with [Awestruct](https://github.com/awestruct/awestruct).

Out of nostalgia, I played with the [Wayback Machine](https://web.archive.org/) to remember of my web site looked over the years.

The [initial version](https://web.archive.org/web/20040608163211/http://www.jmesnil.net/weblog/) was hosted on [Movable Type](https://www.movabletype.org) using their standard template.
I made some [terrible visual choice](https://web.archive.org/web/20050305002431/http://www.jmesnil.net/weblog/) that I quickly removed for a [cluttered look](https://web.archive.org/web/20060718074004/http://jmesnil.net/weblog/) before going full page on the [content](https://web.archive.org/web/20101123153014/http://jmesnil.net/weblog/) that I stripped down to the [current design](https://jmesnil.net/weblog/).

On the technical side, I don't remember all the solutions but I used Movable Type, BlogPost, WordPress.
Eventually, I switched to a static generation of the content from Markdown pages in a [Git repository](https://github.com/jmesnil/jmesnil.net/) that are pushed to a AWS S3 Bucket.

The latest technical changes I did were to use a container image to manage all the Ruby dependencies from Awestruct and adding a [TLS Certificate to the server](https://jmesnil.net/weblog/2023/09/13/tls-certificate-on-jmesnil/).

I have had bursts of activity on my web site and long periods of neglects but it is still great to have a place I can call my own on the Web...