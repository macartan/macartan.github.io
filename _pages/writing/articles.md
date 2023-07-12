---
layout: page
permalink: /writing/articles/
title: articles
description:
nav: false
nav_order: 1
---
<!-- _pages/publications.md -->
<div class="publications">

  {% bibliography -f papers -q @article %}
  
  {% for article in site.data.bibliography.papers %}
    {% if article.type == "article" %}
      <h3>{{ article.title }}</h3>
      <p>{{ article.author }}</p>
      {% assign download_link = article.file | relative_url %}
      {% if download_link %}
        <a href="{{ download_link }}" class="btn btn--primary btn--small" download>Download Zip</a>
      {% endif %}
    {% endif %}
  {% endfor %}

</div>



