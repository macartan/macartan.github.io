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

Legacy: See an earlier working paper with core ideas in the book:
[Qualitative inferences from Causal Models]("2017_qualdag.pdf")

##  Pedagogical material

*  [Lectures on causal inference](https://macartan.github.io/ci/ci_2024.html#/title-slide) | [exercises etc](https://macartan.github.io/ci/)


    * [Intro](https://macartan.github.io/ci/1.1_intro.html)
    * [Design declaration](https://macartan.github.io/ci/1.2_declaredesign.html)
    * [Causality](https://macartan.github.io/ci/2.1_causality.html)
    * [Estimands and Identification](https://macartan.github.io/ci/2.2_estimands.html)
    * [Frequentists inference](https://macartan.github.io/ci/3.1_fisher.html)
    * [Bayesian inference](https://macartan.github.io/ci/3.2_bayes.html)
    * [Experimental design](https://macartan.github.io/ci/4.1_design.html)
    * [Design evaluation](https://macartan.github.io/ci/4.2_evaluation.html)
    * [Topics (Diff in Diff, RDD, IV, other)](https://macartan.github.io/ci/5.1_topics.html)
    * [Workflows](https://macartan.github.io/ci/5.2_process.html)

Other

* <i class="fas  fa-presentation"></i> <a href="{{'slides/201807_Berlin_Summer_School.pdf' | relative_url}}"  rel="noopener noreferrer"> Of causes and postulates: Slides for the Berlin summer school in social sciences 2018</a> 

* <i class="fas fa-link"></i> <a href="https://egap.org/resource/10-strategies-for-figuring-out-if-x-caused-y/">Ten strategies for figuring out causal effects</a>

* <i class="fas fa-link"></i> <a href="https://egap.org/resource/10-things-to-know-about-causal-inference/"> Ten things you need to know about causal inference</a>

* <i class="fas fa-link"></i> <a href="https://egap.org/methods-guides/"> Other egap guides</a>


## Short working papers


<!-- _pages/publications.md -->
<div class="publications">

  {% bibliography -f papers -q @*[keywords~=causal inference]* %}

</div>
