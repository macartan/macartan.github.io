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

  {% bibliography -f papers -q @book %}

</div>



Experimental

<div class="publications">

{% bibliography -q @*[keywords ~= experimental]* %}

</div>



Health

<div class="publications">

{% bibliography -q @*[keywords ~= health]* %}

</div>


