---
layout: page
title: Hello World!
tagline: Supporting tagline
---
{% include JB/setup %}


<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; 
    <a href="{{ BASE_PATH }}{{ post.url }}">{% unless post.link %} {{ site.linked_list.post }} {% endunless %} {{ post.title }}</a></li>
  {% endfor %}
</ul>


