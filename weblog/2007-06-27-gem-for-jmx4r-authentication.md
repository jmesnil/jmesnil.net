---
date: '2007-06-27 18:54:27'
layout: post
slug: gem-for-jmx4r-authentication
status: publish
title: Gem for jmx4r + authentication
wordpress_id: '156'
tags:
- java
- jmx
- jmx4r
- jruby
- ruby
---

[jmx4r][jmx4r] is a library for [JRuby][jruby] to make it super easy to write Ruby scripts to manage remote Java applications through JMX.

Thanks to [RubyForge][rubyforge], installing jmx4r is now as simple as typing

    jruby -S gem install jmx4r

and its use is straightforward

    #!/usr/bin/env jruby
    require 'rubygems'
    require 'jmx4r'    

    # optional since by default, jmx4r tries to connect to 
    # a JMX Server on localhost which listens to port 3000
    JMX::MBean.establish_connection :host => "localhost", :port => 3000    

    memory = JMX::MBean.find_by_name "java.lang:type=Memory"
    # trigger a Garbage Collection
    memory.gc

Since my [previous post on jmx4r][annoucement], I've added [unit tests][tests] and some [examples][examples] to highlight its features. It still needs to be properly documented though...

However, one new feature is worth mentioning: jmx4r now supports connection authentication

    JMX::MBean.establish_connection :host => "localhost",
    :username => "jeff", :password => "secret"

If you're using it, I'm very interested to now what you think about it.  
And if you encounter any problem, do not hesitate to [submit a bug][tracker].

[jmx4r]:       http://code.google.com/p/jmx4r/
[jruby]:       http://jruby.codehaus.org
[rubyforge]:   http://rubyforge.org/projects/jmx4r/
[annoucement]: http://jmesnil.net/weblog/2007/06/11/jmx4r-a-jmx-libary-for-jruby/
[tests]:       http://jmx4r.googlecode.com/svn/trunk/test/
[examples]:    http://jmx4r.googlecode.com/svn/trunk/examples/
[tracker]:     http://code.google.com/p/jmx4r/issues/list
