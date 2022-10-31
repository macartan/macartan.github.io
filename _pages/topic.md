---
layout: page
permalink: /publications/by_topic
title: topics
description:
nav: false
nav_order: 1
key: [development, violence, methods, experimental, theory, health, identity politics]
---


<a name="top"></a>

* [Development](#development) 
* [Methods](#methods) 
* [Formal theory](#theory) 
* [Experimental studies](#experimental) 
* [Health](#health) 
* [Political violence](#violence)



<div class="publications">

{%- for x in page.key %}
  <h1 class="key" id = {{x}}>{{x}}</h1>
  {% bibliography -f papers -q @*[keywords~={{x}}]* %}
<a href="#top">Back to top of page</a>
{% endfor %}

</div>



