---
layout: post
title: "Ambiguous implications of collider bias for the estimation of discrimination"
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

**Summary**: 
[Knox, Lowe, and Mummolo](https://www.cambridge.org/core/journals/american-political-science-review/article/administrative-records-mask-racially-biased-policing/66BC0F9998543868BB20F241796B79B8) argue  that ["traditional analyses understate racial bias in police violence"]("https://twitter.com/jonmummolo/status/1275790509647241222"). They bring attention to the important but underappreciated point that conditioning analysis on data from the set of police stops can introduce  "collider bias." In a dispute with [Gaebler et al](https://twitter.com/jonmummolo/status/1275790509647241222) they dismiss a condition that ensures no such bias for being "knife edge." Interestingly however the condition is less an edge as a border: on the other side of the border, bias can go in the opposite direction, and one type of discrimination can be over-estimated while another type is even more severely underestimated. 

I unpack this all below but emphasize right away that the point here is not that Knox et al. are wrong, but rather to highlight how much the overall conclusions really ride on an assumption that has escaped attention during this debate.

The methodological takeaways are: 

*  yes we have to worry about collider bias, but *knowing that there are risks of collider bias does not tell us what direction estimation bias will go in*
* if bias can indeed go in different directions we should be *seeking to understand the nature of bias rather than either asserting conditions to ensure it goes one way or focusing on conditions that make it go away*  



# Model recap

We are imagining a model in which being stopped by the police ($$M=1$$), and thus entering administrative data, depends on race ($$D$$) as well as some unobserved feature of the situation ($$U$$). Both $$D$$ and $$U$$ might also affect whether force gets used if you are stopped.[^1] $$U$$ might be how suspicious you are perceived to be, or it might be something about the context or location, or it might be something about the police you are engaging with. For this note I will assume that $$U$$ is binary.

[^1]:So the DAG is: **Y &larr; D &rarr; M &rarr; Y &larr; U &rarr; M**.

The  conditional distributions of variables is as follows:

1. $$M$$ depends on $$D$$ and $$U$$. Let $$p_{du}$$ denote the probability of being stopped if $$D=d$$ and $$U=u$$.

2. In the case in which $$m=1$$, $$Y$$ also depends on $$D$$ and $$U$$ (otherwise, if $$m=0$$, $$Y=0$$). Let $$y_{du}$$ denote the average value of $$Y$$  if $$D=d$$ and $$U=u$$ among the cases with $$m=1$$. 

3. We also need distributions on $$D$$ and $$U$$. For simplicity let's assume that $$\Pr(D=1) = \Pr(U=1) = .5$$. Note that these are independent.

We also assume that $$M$$ is monotonic in $$D$$. That's assumption 2 in [Knox, Lowe, and Mummolo](https://www.cambridge.org/core/journals/american-political-science-review/article/administrative-records-mask-racially-biased-policing/66BC0F9998543868BB20F241796B79B8). It's a very strong assumption and imposes structure beyond what is available from knowledge of these distributions.

That's the model. 

# Estimands and estimators

We have enough information here to write the estimands and estimates in terms of $$p_{du}$$ and $$y_{du}$$. 


The estimands are:
  (formulas to be added)

In words, the $$ATE$$ is the effect of $$D$$ on getting stopped and experiencing force (averaged over eh different $$U$$ types).  $$CDE_{M=1}$$ is the average affect of $$D$$ on force among those in the $$M=1$$ group, keeping $$M=1$$ fixed as we consider counterfactual changes in $$D$$. $$ATE_{M=1}$$ is the average affect of $$D$$ on force among those in the $$M=1$$ group, but allowing $$M$$ to change as we consider counterfactual changes in $$D$$.
 
Note that if $$M$$ is monotonic in $$D$$ then $$ATE_{M=1}>CDE_{M=1}$$, the difference arising from the increased chance of being observed times force in the $$D=0$$ condition (the difference between outcomes in the $$D=1$$ condition and the  $$D=0$$ condition being captured already in the CDE part).

For the  estimator we will assume we have *lots* of data. We focus on the "naive estimate," which takes the difference in $Y$ among $$M=1$$ types for $$D=1$$ and $$D=0$$ types:


$$\hat{b} = \frac{p_{10} y_{10} + p_{11}y_{11}}{p_{10} + p_{11}} - \frac{p_{00} y_{00} + p_{01}y_{01}}{p_{00} + p_{01}}$$

