---
layout: page
permalink: /publications/books
title: books
description:
nav: false
nav_order: 1
---
<!-- _pages/publications.md -->
<div class="publications">

  {% bibliography -f papers -q @book | sort_by:year %}

</div>




