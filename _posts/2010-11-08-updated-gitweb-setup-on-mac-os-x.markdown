---
date: '2010-11-08 21:59:58'
layout: post
slug: updated-gitweb-setup-on-mac-os-x
status: publish
title: (Updated) Gitweb Setup on Mac OS X
wordpress_id: '1279'
tags:
- git
- macosx
---

<div style="font-size: 4em; padding: 10px;">
<a href="http://git.or.cz/"><img src="http://git.or.cz/git-logo.png" alt="Git logo" style="vertical-align:middle;"></a>
+ 
<a href="http://apple.com/"><img src="http://images.apple.com/global/elements/buystripmodule/buystrip-icon-retail.gif" alt="Apple logo" class=style ="vertical-align:middle;"/></a>
</div>

I wrote a post about [setting up Gitweb on Mac OS X][setup] 2 years ago. Today I was reading it again to setup gitweb on another Mac and the steps have slightly changed.

It assumes that [Git][git] is installed in `/usr/bin` (otherwise, modify the `bindir` property accordingly).  
You just need to modify `GITWEB_PROJECTROOT` to point to the root of your Git projects.

To install `gitweb` (from Git 1.7.2.1) on Mac OS X 10.6.4, the steps are now:

{% highlight sh %}
# define the projects root
export GITWEB_PROJECTROOT="/Users/jmesnil/Git/"

# retrieve the latest version of git
git clone git://git.kernel.org/pub/scm/git/git.git
cd git/

# install gitweb.cgi
sudo make GITWEB_PROJECTROOT=$GITWEB_PROJECTROOT \
     GITWEB_CSS="/gitweb/gitweb.css" \
     GITWEB_LOGO="/gitweb/git-logo.png"  \
     GITWEB_FAVICON="/gitweb/git-favicon.png"  \
     GITWEB_JS="/gitweb/gitweb.js" \
     bindir=/usr/bin \
     gitwebdir=/Library/WebServer/CGI-Executables/gitweb \
     install-gitweb

# move the static files to the proper folder
mkdir -p /Library/WebServer/Documents/gitweb
cd /Library/WebServer/
mv CGI-Executables/gitweb/static/* Documents/gitweb     
{% endhighlight %}

and go to [http://localhost/cgi-bin/gitweb/gitweb.cgi](http://localhost/cgi-bin/gitweb/gitweb.cgi)

[setup]: http://jmesnil.net/weblog/2008/07/31/gitweb-setup-on-mac-os-x/
[git]: http://git.or.cz/