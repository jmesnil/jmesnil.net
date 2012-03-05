---
date: '2008-04-15 19:40:23'
layout: post
slug: shell-history-meme
status: publish
title: ⚑ Shell history meme
wordpress_id: '170'
tags:
- misc
---




    
    
    ~$ uname -a
    Darwin macbook.local 9.2.2 Darwin Kernel Version 9.2.2: Tue Mar  4 21:17:34 PST 2008; root:xnu-1228.4.31~1/RELEASE_I386 i386 i386
    ~$ history|awk '{a[$2]++} END{for(i in a){printf "%5d\t%s\n ",a[i],i}}'|sort -rn|head
       132  git
        63  cd
        55  jruby
        54  ant
        42  ls
        30  rake
        14  rm
        13  ./bin/runtest
        12  vim
        11  ps
    



I guess I'm having fun learning [Git][git] with [jmx4r][jmx4r].

[Meme via [Stefan][tilkov]]

[git]: http://git.or.cz/
[jmx4r]: http://code.google.cm/p/jmx4r/
[tilkov]: http://www.innoq.com/blog/st/2008/04/stupid_meme_time_again.html
