---
date: '2010-11-20 18:45:38'
layout: post
slug: jmx4r-0-1-3-is-released
status: publish
title: jmx4r 0.1.3 Is Released
wordpress_id: '1324'
tags:
- jmx4r
---

[jmx4r][jmx4r] 0.1.3 has just been released (jmx4r is a JRuby library which makes it super easy to write simple Ruby scripts to manage Java & JRuby applications using JMX).

There is a single new feature on this release:

* JMX `CompositeData` attributes can now be accessed as Ruby attributes.  

Before, to access the `committed` attribute of the `heap_memory` composite data, you needed to write:

      memory.heap_memory_usage.get("committed")
      
      # or
      
      memory.heap_memory_usage["committed"]

while now, you can simply do:

      memory.heap_memory_usage.committed

You write the attribute like a normal snake_cased attribute and jmx4r will automatically retrieve the corresponding CamelCased attribute from the composite data.

Thanks to [Dominique Broeglin][dg] who contributed this enhancement.

When I pushed the new gem on [RubyGems.org][rubygems], I also noticed that the RDoc is automatically published to [rubydoc.info][rubydoc] and looks much better that the old version that I was pushing to Rubyforge.

As usual, to get this new release, just update the rubygem:

    jruby -S gem install jmx4r

and do not hesitate to contribute:

    git clone git://github.com/jmesnil/jmx4r.git

[jmx4r]: http://github.com/jmesnil/jmx4r
[dg]: http://dominique.broeglin.fr/
[rubygems]: https://rubygems.org/gems/jmx4r
[rubydoc]: http://rubydoc.info/gems/jmx4r/frames
