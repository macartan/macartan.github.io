---
layout: page
title: Causal inference
img: assets/img/posts/dag.png
importance: 3
category: methods
---

## Book on causal models for qualititative and mixed methods research

Alan Jacobs and I have been working on figuring out principles for simultaneously drawing inferences from qualitative and quantitative data. The key idea is that when scholars use qualitative inference they update beliefs about causal effects (or more, generally about their model of the world, $$M$$) by making inferences using data about many facts of a given case ($$ D_1 $$). They estimate a posterior $$ \Pr(M  \vert  D_1) $$. Quantitative  scholars update beliefs about causal effects by making inferences using data about a few facts about many cases ($$D_2$$), forming posterior $$\Pr(M \mid D_2)$$.  From there it’s not such a huge thing to make integrated inferences of the form $$\Pr(M \vert D_1\&D_2)$$.

Simple as that sounds, people do not do this, but doing it opens up many insights about how we learn from cases and how we aggregate knowledge. The broad approach becomes considerably more powerful when causal models are used to justify beliefs on data patterns.

Alan and I develop these ideas in our book  <i class="fas fa-book"></i> <a href="https://macartan.github.io/integrated_inferences/"> Integrated inferences</a> (with Alan Jacobs, Cambridge University) and provide a package  [CausalQueries](https://github.com/macartan/CausalQueries) to implement these ideas. (See also our 
[guide to our package for making, updating, and querying causal models](https://macartan.github.io/causalmodels/)).

##  Pedagogical material

* <strong><a href="https://web.archive.org/web/20190721083550/http://www.macartan.nyc/wp-content/uploads/2015/08/causal.inference.pdf"><img class="wp-image-137 alignnone" src="https://web.archive.org/web/20190721083550im_/http://www.macartan.nyc/wp-content/uploads/2015/08/Slides.png" alt="Slides" width="25" height="25" /> </a></strong><a href="http://macartan.nyc/wp-content/uploads/2020/09/six_lectures.pdf">six_lectures on causal inference</a>

* <i class="fa  fa-presentation"></i> <a href="{{'slides/201807_Berlin_Summer_School.pdf' | relative_url}}"  rel="noopener noreferrer"> Of causes and postulates: Slides for the Berlin summer school in social sciences 2018</a> 

* <i class="fas fa-link"></i> <a href="https://egap.org/resource/10-strategies-for-figuring-out-if-x-caused-y/">Ten strategies for figuring out causal effects</a>

* <i class="fas fa-link"></i> <a href="https://egap.org/resource/10-things-to-know-about-causal-inference/"> Ten things you need to know about causal inference</a>

* <i class="fas fa-link"></i> <a href="https://egap.org/methods-guides/"> Other egap guides</a>


## Short working papers


<!-- _pages/publications.md -->
<div class="publications">

  {% bibliography -f papers -q @*[keywords~=causal inference]* %}

</div>
