---
layout: page
permalink: /writing/books/
title: books
description:
nav: false
nav_order: 4
---
<!-- _pages/publications.md -->
<div class="publications">

  {% bibliography -f papers -q @books | sort_by:year %}

</div>




