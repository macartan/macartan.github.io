---
layout: post
title: "Conditioning on a collider (a bit technical)"
date: 2020-06-29
output: 
  html_document:
    keep_md: true
description: 
---



<!-- Frequent Worries about RCTs: Questions and Answers -->

<!-- Author: Macartan Humphreys -->

* TOC 
{:toc}

# Summary

[Knox, Lowe, and Mummolo](https://www.cambridge.org/core/journals/american-political-science-review/article/administrative-records-mask-racially-biased-policing/66BC0F9998543868BB20F241796B79B8) in an important study show how standard estimators underestimate discrimination when a set of plausible conditions hold. The study provides a textbook example of risks of bias that can arise from a common strategy for estimating discrimination. ([Here is a less technical note](https://macartan.github.io/i/notes/collider_estimands.html) that builds off [Bronner's](https://fivethirtyeight.com/features/why-statistics-dont-capture-the-full-extent-of-the-systemic-bias-in-policing/) nice explainer with a walk through the intuition with a focus on collider bias.)

Since then:

* Gaebler et al provide a counterexample to [Knox, Lowe, and Mummolo](https://www.cambridge.org/core/journals/american-political-science-review/article/administrative-records-mask-racially-biased-policing/66BC0F9998543868BB20F241796B79B8) here:
https://gist.github.com/jg43b/a5926fc98bf26cb157f4001d5a76f5a9

* Knox et al dismiss the counterexample as trickery. https://twitter.com/dean_c_knox/status/1276508890990075904 

* I think there's a bit more to it. 

Here I "declare" a version of this counterexample, confirm that it is indeed a counterexample (and that there are more like it!) and dig a little into what is needed for this kind of counterexample. I agree with Knox et al that the example is indeed "knife edge" (in the sense that it holds for a parameter set that live on a plane in a cube) and so unlikely. But I still find it striking---and useful---to see that there are edges in which all "arrows" are strong but collider bias is weak. I know I at least had been thinking of the countercases as involving essentially removing arrows from the causal graph. Rather than dismissing the examples I think useful to assess the conditions under which collider bias is more or less of a concern.


# The counterexample really is a counterexample with real causal relations between nodes

The example involves a situation in which there is a graph with a path of the form ***D &rarr; M &larr; U*** but for which $$D$$ is independent of $$U$$ when $$M=1$$. Specifically we have this causal graph involving $$D$$ (Race), $$M$$ (Being stopped), $$U$$ (Unobserved factor affecting stops and the use of force) and $$Y$$ (use of force).

{% highlight s linenos %}
library(CausalQueries)
make_model("Y <- D -> M -> Y <- U; U ->M") %>% plot
{% endhighlight %}

<img src="https://macartan.github.io/assets/img/dag.png" width="816" height="474">

I use [DeclareDesign](declaredesign.org) to declare the design and counterexample which lets us assess properties of the design quickly.

Declaration in this chunk:

{% highlight s linenos %}
pr_D = .66  # Probability D = 1
pr_U = .45  # Probability U = 1
a <- 4      # A parameter

design <-
  
  declare_population(N = 10000,
                     D = rbinom(N, size = 1, prob = pr_D),
                     U = rbinom(N, size = 1, prob = pr_U)) +
  declare_potential_outcomes(M ~ rbinom(N, size = 1,  prob = (1+3*D)*(1+U)/8),
                             conditions = list(D = 0:1, U = 0:1)) +
  declare_reveal(outcome_variables = "M", assignment_variables = c("D", "U")) +
  declare_potential_outcomes(Y ~ M*rbinom(N, size = 1, prob = (1+D)*(1+U)/a),
                             conditions = list(D = 0:1)) +
  declare_reveal(outcome_variables = "Y",
                 assignment_variables = c("D")) +
  declare_estimand(CDE = mean((Y_D_1 - Y_D_0)[M==1])) +
  declare_estimator(Y ~ D, subset = M == 1, estimand = "CDE")
  
{% endhighlight %}

