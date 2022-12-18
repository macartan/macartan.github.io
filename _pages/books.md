---
layout: page
permalink: /publications/wp
title: books
description:
nav: false
nav_order: 4
---
<!-- _pages/publications.md -->
<div class="publications">

  {% bibliography -f papers -q @unpublished | sort_by:year %}

</div>




