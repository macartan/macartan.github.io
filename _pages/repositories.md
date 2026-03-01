---
layout: page
permalink: /repositories/
title: packages
description: Github repos
nav: true
nav_order: 3
---

## GitHub Repositories

{% if site.data.repositories.github_repos %}
<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for repo in site.data.repositories.github_repos %}
    {% include repository/repo.html repository=repo %}
  {% endfor %}
</div>
{% else %}
<p>Repository list is configured in <code>_data/repositories.yml</code> under <code>github_repos</code>.</p>
{% endif %}
