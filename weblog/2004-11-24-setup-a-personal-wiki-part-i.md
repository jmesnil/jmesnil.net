---
date: '2004-11-24 13:11:53'
layout: post
slug: setup-a-personal-wiki-part-i
status: publish
title: Setup a personal Wiki (Part I)
wordpress_id: '52'
tags:
- web
---

I finally decided to setup a personal [Wiki](http://en.wikipedia.org/wiki/Wiki) on my web site.



I have taken the habit to use plain text files to keep track of my daily work. I can then simply use `grep` when I need to retrieve any information. I have files for every week that I fill as I work.
It went quite well for some time but it has reached some shortcomings and I'm looking for an alternative.

 The main disadvantage of plain text files is that is not internet friendly. Most of my work deals with URL (bugzilla URL, corporate wiki URL, client site URL generating errors,...). It's not a big deal to copy/paste from the files to the browser but when you have to do very often everyday, it becomes boring.
Secondly, it's quite inconvenient to backup these files. I let them in the home directory on the workstation of my client company but I've to think to back them up weekly or monthly on my USB drive.
I also need from time to time to refer from a file to another one (e.g. I encounter a problem I've worked on weeks ago and I'd like to refer to the first encounter without repeating myself). plain text is not good for such resource links...





My requirement for these files were pretty simple:





  
  * they should be be viewable directly in a web browser to take advantage of the URLs
  * they should be stored on my web server so that I can access them from anywhere...
  * ... but I should be the only one allowed to view them
  * it should be simple and straightforward to edit and modify them without uploads every time
  * the file format should be as close as possible from plain text to keep editing simple
  * Files should be searchable efficiently





A wiki meets all these requirements but the authorization one (more on that later). So I decided to give it a try and install a personal Wiki on my [hosted web site](http://www.jmesnil.net).





I had to take into account my web site requirements to choose the right Wiki implemenation (among [all the available ones](http://c2.com/cgi/wiki?WikiEngines)):





  
  * only Perl, Python or PHP implementation
  * if a database is needed, only MySQL is an option
  * I don't have a SSH access, so the installation and configuration setup has to be done only through the web or FTP





With these requirements in mind, I made a (completely subjective) short list:





  
  * [MoinMoin](http://moinmoin.wikiwikiweb.de/)
  * [Twiki](http://www.twiki.org/)
  * [PhpWiki](http://phpwiki.sourceforge.net/)
  * [UseMod](http://usemod.com/cgi-bin/wiki.pl)
  * [MediaWiki](http://meta.wikimedia.org/wiki/Main_Page)



I did not find enough information on MoinMoin to install it without shell access. I had the opportunity to use Twiki and I don't like it (it works great but I find it too bloated). I did not find any clear installation documentation on PhpWiki web site (it didn't pass my 5-minute test).   
So the only remaining ones were UseMod and MediaWiki. And both had good documentation and were a breeze to install.


[UseMod](usemod.com/cgi-bin/wiki.pl) is a no-nonsense Wiki, very similar to the [original Wiki](http://c2.com/cgi/wiki?). One Perl script, one data directory to store the files and that's it. You just have to change a few settings in the script, upload it on the web site and create the wiki directory.




[MediaWiki](http://meta.wikimedia.org/wiki/Main_Page) has more features than UseMod. It is based on PHP and MySQL but is also very simple to install. You just have to upload a directory on your web site and use the web based wizard to configure everything (including MySQL tables). There is some `chmod` to do but nothing more complicate (It's quite similar to the installation of [Movable Type](http://movabletype.org/)).  

So in less than twenty minutes, I had downloaded and configured these two Wiki engines on my web site.





Next time, a comparison between the two and which one I finally decided to use.



