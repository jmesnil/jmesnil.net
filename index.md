---
layout: default
title: Weblog
---
{% include JB/setup %}

{% for post in site.posts limit:10 %}


{% if post.link %}
<article class="link">
<h1><a href="{{ post.link }}">{{ post.title }} {{ site.linked_list.link }}</a></h1>
{% else %}
<article class="post">
<h1><a href="{{ BASE_PATH }}/{{ post.url }}">{{ site.linked_list.post }} {{ post.title }}</a></h1>
{% endif %}

{{ post.content }}

</article>
{% endfor %}
