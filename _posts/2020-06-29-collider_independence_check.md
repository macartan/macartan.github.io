---
title: "Wrong sign?"
author: "Macartan Humphreys"
date: "6/29/2020"
output: 
  html_document:
    keep_md: true
---




# An example in which the naive estimate *over*estimates the discrimination among the stopped 

In the figure below black entries are "stopped" ($M=1$) and grey not ($M=0$) and a 1 indicates a use of force if stopped and a 0 indicates no use of force if stopped.

So a black 1 means stopped and force employed.

$D$ indicates minority status and $U$ is an independent variable denoting "suspiciousness." These are not correlated with each other. Both $M$ and use of force if stopped are increasing in both $D$ and $U$.




```r
df <- expand.grid(D=0:1, U = 0:1, r = 1:4, c = 1:3) %>%
  mutate(M    = 1*(r==1 | (r==2 & D==1)| (r==3 & D*U ==1)),
         Y_if = 1*(((D+U)>0 & c ==3) | ((D+U)>1 & c ==2)),
         Y    = M*Y_if
         ) 
ggplot(df) + aes(c, r) + facet_grid(U ~ D, labeller = label_both) +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(), plot.background=element_blank()) +
  geom_text(aes(label=Y_if), color = ifelse(df$M==1, "black", "grey"))
```

![](collider_independence_check_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

* The effect of $D$ on $Y$ among the stopped is 9/21: 43%. 
* The *controlled direct effect* of $D$ on $Y$ among the stopped is 7/21: 33%. 
* The naive estimate for the effect of $D$ is: (8/15) - (1/6) = 37%

So the naive estimate overestimates the controlled direct effect but not the average effect, among the stopped.  This is confirmed in the design declaration below.

# Why?

The example here violates the assumption of "relative non severity of racial stops" (Assumption 3):

* Force is used for (3/6) minorities that are stopped regardless of race.
* Force is used for (5/9) minorities that are stopped *because* of race.

If you think that racist stops are possibly going to involve *more* force then you might be worried about this counterexample.

# Declaration


Here is a declaration and diagnosis of a stochastic version of this model:


```{.r .fold-show}
pr_D <- .66  # Probability D = 1
pr_U <- .45  # Probability U = 1
a    <- 0    # A parameter

design <-
  
  declare_population(N = 10000,
                     D = rbinom(N, size = 1, prob = pr_D),
                     U = rbinom(N, size = 1, prob = pr_U)) +
  
  declare_potential_outcomes(M ~ rbinom(N, size = 1,  prob = (1+D+a*U+D*U)/4),
                             conditions = list(D = 0:1, U = 0:1)) +
  declare_reveal(outcome_variables = "M", assignment_variables = c("D", "U")) +
  declare_potential_outcomes(Y ~ M*rbinom(N, size = 1, prob = (D+U)/3),
                             conditions = list(D = 0:1)) +
  declare_reveal(outcome_variables = "Y",
                 assignment_variables = c("D")) +
  declare_estimand(CDE = mean((Y_D_1 - Y_D_0)[M==1])) +
  declare_estimator(Y ~ D, subset = M == 1, estimand = "CDE")
```

```
## Warning: 'declare_estimand' is deprecated.
## Use 'declare_inquiry' instead.
## See help("Deprecated")
```


Here is the diagnosis:


```r
redesign(design, a = 0:1) %>% 
  diagnose_design %>% reshape_diagnosis %>% kable(caption = "Diagnosis")
```

```
## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.

## Warning: The argument 'estimand = ' is deprecated. Please use 'inquiry = '
## instead.
```



Table: Diagnosis

|Design   |a  |Inquiry |Estimator |Outcome |Term |N Sims |Mean Estimand |Mean Estimate |Bias   |SD Estimate |RMSE   |Power  |Coverage |
|:--------|:--|:-------|:---------|:-------|:----|:------|:-------------|:-------------|:------|:-----------|:------|:------|:--------|
|design_1 |0  |CDE     |estimator |Y       |D    |500    |0.33          |0.37          |0.03   |0.02        |0.04   |1.00   |0.34     |
|         |   |        |          |        |     |       |(0.00)        |(0.00)        |(0.00) |(0.00)      |(0.00) |(0.00) |(0.02)   |
|design_2 |1  |CDE     |estimator |Y       |D    |500    |0.33          |0.33          |-0.00  |0.01        |0.01   |1.00   |0.98     |
|         |   |        |          |        |     |       |(0.00)        |(0.00)        |(0.00) |(0.00)      |(0.00) |(0.00) |(0.01)   |

* Note that in the `a=1` case there is no collider bias.
* In the `a=0` case we get an overestimate of CDE|M=1.
