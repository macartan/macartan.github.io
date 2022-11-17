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

```r
library(CausalQueries)
make_model("Y <- D -> M -> Y <- U; U ->M") %>% plot
```
![](https://macartan.github.io/assets/img/dag.png)

I use [DeclareDesign](declaredesign.org) to declare the design and counterexample which lets us assess properties of the design quickly.

Declaration in this chunk:

```r
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
  
```

Sample data can be drawn from the design:

```r
df <- draw_data(design)
```
We see that the variables that should be correlated with each other are correlated with each other:

```r
df %>% select(D, M, U, Y) %>% cor %>% kable
```

|   |          D|         M|          U|         Y|
|:--|----------:|---------:|----------:|---------:|
|D  |  1.0000000| 0.5206849| -0.0172115| 0.4868161|
|M  |  0.5206849| 1.0000000|  0.3677719| 0.7731379|
|U  | -0.0172115| 0.3677719|  1.0000000| 0.5301634|
|Y  |  0.4868161| 0.7731379|  0.5301634| 1.0000000|

Here is the diagnosis:

```r
design %>% 
  diagnose_design %>% reshape_diagnosis %>% kable(caption = "Diagnosis")
```

Table: Diagnosis

|Design |Inquiry |Estimator |Outcome |Term |N Sims |Mean Estimand |Mean Estimate |Bias   |SD Estimate |RMSE   |Power  |Coverage |
|:------|:-------|:---------|:-------|:----|:------|:-------------|:-------------|:------|:-----------|:------|:------|:--------|
|.      |CDE     |estimator |Y       |D    |500    |0.40          |0.40          |-0.00  |0.02        |0.02   |1.00   |0.97     |
|       |        |          |        |     |       |(0.00)        |(0.00)        |(0.00) |(0.00)      |(0.00) |(0.00) |(0.01)   |


And here is the diagnosis of a perturbed design. Here I just change parameter `a` and diagnose again.

```r
design %>% 
  redesign(a = 5) %>% diagnose_design %>% reshape_diagnosis %>% kable(caption = "A perturbation")
```
Table: A perturbation

|Design |a  |Inquiry |Estimator |Outcome |Term |N Sims |Mean Estimand |Mean Estimate |Bias   |SD Estimate |RMSE   |Power  |Coverage |
|:------|:--|:-------|:---------|:-------|:----|:------|:-------------|:-------------|:------|:-----------|:------|:------|:--------|
|.      |5  |CDE     |estimator |Y       |D    |500    |0.32          |0.32          |-0.00  |0.02        |0.02   |1.00   |0.98     |
|       |   |        |          |        |     |       |(0.00)        |(0.00)        |(0.00) |(0.00)      |(0.00) |(0.00) |(0.01)   |



# Why no collider bias?

We can see in the data that conditional independence seems to hold when $$M=1$$ despite $$M$$ being a collider:

```r
df %>% filter(M==1) %>% select(D, U) %>% cor
```
```
            D           U
D  1.00000000 -0.02826486
U -0.02826486  1.00000000
```

Though not when $$M=0$$.

```r
df %>% filter(M==0) %>% select(D, U) %>% cor
```
```r
           D          U
D  1.0000000 -0.4775497
U -0.4775497  1.0000000
```

Why is that? Is the counterexample "generic"?

Pearl readers expect such exceptions to be rare, but let's look more carefully to see why we get an exception here. Let's say **p<sub>u,d,m</sub>** is the probability that $$U=u, D=d$$ and $$M=m$$. We are interested in whether $$U$$ and $$D$$ are independent given $$M=1$$. Now let's ask in particular if $$\Pr(U=1 | D=1, M=1)= \Pr(U=1 | D=0, M=1)$$

Or:

$$\frac{p_{1,1,1}}{p_{1,1,1} + p_{0,1,1}} = \frac{p_{1,0,1}}{p_{1,0,1} + p_{0,0,1}}$$

$$({p_{1,0,1} + p_{0,0,1}} ){p_{1,1,1}} = ({p_{1,1,1} + p_{0,1,1}}){p_{1,0,1}}$$
$${p_{0,0,1}} {p_{1,1,1}} = {p_{0,1,1}}{p_{1,0,1}}$$


Note that given the graph, this does not depend on $$\Pr(U=1)$$ or $$\Pr(D=1)$$ but rather on whether:

$$\Pr(M=1 | U = 1, D=1)\Pr(M = 1 | U = 0, D=0) = \Pr(M=1 | U = 1, D=0)\Pr(M = 1 | U = 0, D=1)$$


