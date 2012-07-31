---
date: '2008-07-31 22:50:35'
layout: post
slug: gitweb-setup-on-mac-os-x
status: publish
title: Gitweb setup on Mac OS X
wordpress_id: '195'
tags:
- apple
- git
- macosx
---

__Update:__ I have written a new post for an [updated setup with a more recent version of Git][update].

This post is for future references since I had to slightly adapt what is written in the [INSTALL][git-install] file to run [Gitweb][gitweb] on my MacBook.

Assuming all my [Git][git] projects are in `/Users/jmesnil/Work/` and I've already installed Git using [MacPorts][macports] (`sudo port install git-core`), the steps to create `gitweb.cgi` is:

    cd ~/Work
    # retrieve the latest version of git
    git clone git://git.kernel.org/pub/scm/git/git.git
    cd git/
    make GITWEB_PROJECTROOT="/Users/jmesnil/Work/" \
         GITWEB_CSS="/gitweb/gitweb.css" \
         GITWEB_LOGO="/gitweb/git-logo.png"  \
         GITWEB_FAVICON="/gitweb/git-favicon.png"  \
         bindir=/opt/local/bin
         gitweb/gitweb.cgi
    
    # CGI scripts are located in /Library/WebServer/CGI-Executables
    mkdir -p /Library/WebServer/CGI-Executables/gitweb
    sudo cp gitweb/gitweb.cgi /Library/WebServer/CGI-Executables/gitweb/
    
    # And the other resources are in /Library/WebServer/Documents/
    mkdir -p /Library/WebServer/Documents/gitweb
    sudo cp gitweb/gitweb.css gitweb/git-logo.png gitweb/git-favicon.png \   
       /Library/WebServer/Documents/gitweb/
    


Once everything is copied to the right place, Gitweb is up and running: 
[http://localhost/cgi-bin/gitweb/gitweb.cgi?](http://localhost/cgi-bin/gitweb/gitweb.cgi?)

[git-install]: http://repo.or.cz/w/git.git?a=blob_plain;f=gitweb/INSTALL;hb=HEAD
[gitweb]: http://git.or.cz/gitwiki/Gitweb
[git]: http://git.or.cz/
[macports]: http://www.macports.org/
[update]: http://jmesnil.net/weblog/2010/11/08/updated-gitweb-setup-on-mac-os-x/
