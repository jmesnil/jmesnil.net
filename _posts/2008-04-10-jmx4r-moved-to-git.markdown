---
date: '2008-04-10 21:14:38'
layout: post
slug: jmx4r-moved-to-git
status: publish
title: jmx4r moved to git
wordpress_id: '168'
tags:
- git
- java
- jmx
- jmx4r
- ruby
---

I use [Subversion][svn] for my daily work (and CVS before that) but I've never used a distributed VCS before.
One of my ex-colleagues, Marc, explained to me all the advantages of these systems but I never took the time to play with them.  
With all the increasing noise about [Git][git] and [Mercurial][mercurial], I'm now curious to learn more about it.  

Since I learn better by practicing, I moved one of my little projects, [jmx4r][jmx4r], from Subversion to Git and hosted it on [GitHub][github].

I don't use jmx4r at the moment and I don't plan to develop it more (less features is the new black). However, if you have requests for a new feature or enhancement (or bugs), do not hesitate to fill an issue on the [tracker][jmx4r-tracker].  
Or better, clone the Git project:


    
    
    git clone git://github.com/jmesnil/jmx4r.git
    



and start hacking it!

P.S.: 
With the recent release of [JRuby][jruby] 1.1, I also checked that the latest version of jmx4r had no regression.  
Congratulation to the JRuby team for the performance boost since version 1.0!

[git]: http://git.or.cz/
[mercurial]: http://www.selenic.com/mercurial/wiki/
[jmx4r]: http://code.google.com/p/jmx4r/
[github]: http://github.com/jmesnil/jmx4r
[svn]: http://subversion.tigris.org/
[jruby]: http://jruby.codehaus.org/
[jmx4r-tracker]: http://code.google.com/p/jmx4r/issues/list
  *[VCS]: Version Control System
