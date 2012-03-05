---
date: '2005-03-24 23:08:00'
layout: post
slug: continuations-in-ruby
status: publish
title: ⚑ Continuations In Ruby
wordpress_id: '83'
tags:
- ruby
---

**updated** with a code example


Via [Tim Bray](http://www.tbray.org/ongoing/When/200x/2005/03/24/Continuations), I read an example of [Continuations in Ruby](http://www.phubuh.org/Media/Writing/Continuations/).  

The example is very impressive but I didn't grok it at first (I'm still not sure to have understood it yet!).






After some searches on continuations, I found this [funny analogy](http://rubygarden.org/ruby?ContinuationExplanation) on the [RubyGarden Wiki](http://rubygarden.org/ruby?) which helped me to understand better what continuations are.  






I don't see yet where and when I would use them but it's a new way for me to think about the execution of the code that I'm not accustomed to. Very interesting stuff!




Here is the Ruby code corresponding to the [analogy](http://rubygarden.org/ruby?ContinuationExplanation):



    
    <code><verbatim>puts "Walking..."
    turn_left = callcc do | turn_left |
        turn_left
    end
    if turn_left
      puts "Turning left..."
      puts "Bitten by a dog!"
      bitten = callcc do | bitten |
          bitten
      end
      turn_left.call false if turn_left
      puts "I prefer to bleed!"
    else
      puts "Turning right..."
      puts "Hit by a train!"
      bitten.call
      puts "DEAD!!"
    end</verbatim>
    </code>




which outputs



    
    <code>
    Walking...
    Turning left...
    Bitten by a dog
    Turning right...
    Hit by a train!
    I prefer to bleed!
    </code>





The simple example is no better than using `goto` statements but the [example](http://www.phubuh.org/Media/Writing/Continuations/multihitman-callcc.html) in
[Continuations on the Web](http://www.phubuh.org/Media/Writing/Continuations/) shows that continuations can become more powerful than that when they keep state.
