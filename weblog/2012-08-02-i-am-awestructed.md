---
layout: post
title: "I Am Awestructed"
date: '2012-08-02 20:34:30'
category: 
tags: []
---

Did you notice something different on my Web site or my Atom feed?  
You shouldn't as I have successfully migrated from [Jekyll][jekyll] to [Awestruct][awestruct].

A few months ago, I switched my Weblog from [Wordpress][wp] to Jekyll because I wanted to have a simpler, slimmer publishing system that could generate a static Web site and be simple to customize. At first, Jekyll fit the bill nicely but as I was starting to tweak it, I was slowed down by its lack of documentation and customization. I want to be able to extend my publishing system, not fork it.

Searching for an alternative, I looked at Awestruct, written by my Red Hat colleague, [Bob McWhirter][bmw], and liked it.
It is an evolution from Jekyll with a [nice extensible architecture][arch] and [good documentation][doc].

As an example of Awestruct extensibility, I wrote an extension to provide an [Archive page](/weblog/archive/) for my Weblog.
Awestruct defines an extension to create a weblog from a single directory with files matching the format of `YYYY-MM-DD-post-title` (like Jekyll does):

    Awestruct::Extensions::Pipeline.new do
      ...
      extension Awestruct::Extensions::Posts.new '/weblog', :posts
      ...
    end

I wanted to add a page which lists all my posts sorted by ear and month.
I added an extension to Awestruct pipeline for this:

    Awestruct::Extensions::Pipeline.new do
      ...
      extension Awestruct::Extensions::Posts.new '/weblog', :posts
      <em>extension Awestruct::Extensions::PostsArchiver.new '/weblog/archive', :posts, :archive</em>
      ...
    end

This extension takes the `:posts` that were added to the site by the `Posts` extension, sort them in a hierarchy of year / month / posts and put them in the variable named `:archive` that can be used inside the template file `/weblog/archive` ([source code][posts_archiver]).

I could then have a very simple [Haml][haml] template to display the archive:

    ---
    layout: page
    title : Archive
    ---    

    - site.archive.each do |year, monthly_archive|
      %h2= year
      - monthly_archive.each do |month, posts|  
        %h3= month
        %ul
          - posts.each do |post|
            %li
              = "\#{post.date.strftime('%d %B %Y')} &raquo;"
              - if post.link
                %a.link{ :href=>post.url }= "\#{site.linked_list.link} \#{ post.title}"
              - else
                %a{ :href=>post.url }= post.title

Et voila the [result](/weblog/archive/)!

In similar fashion, I have been able to add a [Daring Fireball][df]-style linked list to my Web site and Atom feed by simply adding a `link` metadata to the file front-matter and a few lines of HAM to process it.


[jekyll]: http://jekyllrb.com
[awestruct]: http://awestruct.org
[wp]: http://wordpress.org
[bmw]: http://bob.mcwhirter.org
[doc]: http://awestruct.org/getting_started/
[arch]: http://awestruct.org/extensions/
[posts_archiver]: https://github.com/jmesnil/www.jmesnil.net/blob/master/_ext/posts_archiver.rb
[haml]: http://haml.info/
[df]: http://daringfireball.net/