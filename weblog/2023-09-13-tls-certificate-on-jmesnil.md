---
layout: post
title: "TLS certificate on jmesnil.net"
date: '2023-09-13 06:29:02'
tags:
  - web
---

Web browers now treats sites served by HTTP as "Not secure". I finally caved in and added a TLS certificate
to [jmesnil.net](https://jmesnil.net).

<figure class="portrait">
<img src="#{ site.img_base_url }images/2023-09-13-padlock-displayed.jpg" alt="Displayed Padlock achievement: completed">
<figcaption>Displayed Padlock achievement: completed
</figcaption>
</figure>

If you are visiting [jmesnil.net](https://jmesnil.net), you can now browse it safely and be sure that your credit cards numbers will not be stolen.
That's progress I suppose...

I host my site on Amazon AWS and use a bunch of their services (S3, Route 53, CloudFront, Certificate Manager) to be able to redirect the HTTP traffic
to HTTPS (and the `www.jmesnil.net` URLs to `jmesnil.net`). I will see how much this increase the AWS bill...

More interestingly, I used [Let's Encrypt](https://letsencrypt.org) to generate the certificates. It took me less than 5 minutes to generate it (including the acme
challenge to verify the ownership of the `jmesnil.net` domain name). 
This project is a great example of simplifying and making accessible a complex technology to web publishers.