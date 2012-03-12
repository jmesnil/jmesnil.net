---
layout: page
---
{% include JB/setup %}

{% for post in site.posts limit:10 %}
<section>

  {% if post.link %}
  <h1 class="emphnext"><a href="{{ post.link }}">{{ post.title }} {{ site.linked_list.link }}</a></h1>
  {% else %}
  <h1 class="emphnext"><a href="{{ post.url }}">{{ site.linked_list.post }} {{ post.title }}</a></h1>
  {% endif %}

  {{ post.content }}
</section>
<hr />
{% endfor %}


