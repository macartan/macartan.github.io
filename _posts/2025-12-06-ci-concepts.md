---
layout: post
title: "Descriptive and causal inference; survey experiments and experiments in surveys"
date: 2025-12-6
output: 
  html_document:
    keep_md: true
    toc: true
    number-sections: true
description: "Contentious distinctions."
editor_options: 
  markdown: 
    wrap: sentence
---

* TOC 
{:toc}


Some notes to hopefully clarify ideas around:

* Measurement / inference / causal estimands / descriptive estimands / identification
* What survey experiments are doing

# Concepts

Is there much analytic value in the distinction between causal estimands and descriptive estimands and between measurement and inference?

I think so.

There is a fair bit of thinking behind these and knowing what you are doing has implications for what you are doing so worth at least thinking through the logic behind the distinctions.

## inference v measurement


Measurement is about observing a quantity that exists in the world; inference is about estimating a quantity that is at least partly unobserved.

You can have causal inference or descriptive inference, so the measurement / inference distinction is not itself about causality.

Clarity that you are doing inference rather than measurement clarifies the need for estimates of uncertainty; e.g. average age in a sample or in a population. If you have sample data and you are interested in the sample average, and your quantity is measurable, then just measure, no need for standard errors. If you have sample data and you are interested in the *population* average, and your quantity  is measurable, then do inference and report your standard errors.

## causal v descriptive estimands

The distinction between causal and descriptive is not quite as sharp, but there is something important here. A key idea for many people thinking in terms of the counterfactual model of causation is that the causal effect is defined as the difference between two potential outcomes -- that is, of two things that don't in fact exist, things that "could have" happened. When we talk about description however we are usually talking about describing properties that things actually have, like knowledge, beliefs, values. So: do we think there is an actual thing there to be measured, that can in principle be measured?

Why does this matter for people who think about causality like this? Because it means that if you are interested in causal estimands then it means that you are stuck with having to do inference. If you are interested in descriptive estimands you may or may not have to do inference. You may be able to measure, but you may have to do inference.

This matters to because if your interest is description maybe you can get away without doing inference. Worth checking. Maybe you can ask everyone if they like coffee and also if they like tea. You don't have to randomly ask half if they like coffee and half if they like tea and infer the population answers based on the effect of the question on the answer! Maybe doing it as an experiment rather than a measurement exercise does not add value.

The distinction between descriptive and causal estimands is not always so sharp though. You might question whether all kinds of quantities we might want to describe -- preferences, loyalties -- and so on really "exist" and can be described in this sense even in principle. And you might think that some of these are themselves causal quantities in disguise. For  example if you think of preferences as a summary of the effects of options on choices. So you might think of a quantity such as "being a racist" both as a property that someone has and as a summary of how they react as a function of features of people that encounter.

We discuss this a bit [here](https://book.declaredesign.org/library/experimental-descriptive.html)

As an analogy, we might think of immunity of a disease as a property that someone has, and want to figure out how many have this immunity. We might even be able to measure features that indicate the property (e.g. sicklecell disease for immunity to malaria). In that case we might want to think of this as a descriptive exercise, and even measure the property in a person. But we might also think of (im)munity as fundamentally inferential: this is we are really asking about how a person would behave in different conditions. Similarly for the racist. 

A bit more formally one might imagine a model in which $X \rightarrow Y  \leftarrow A$, binary nodes and functional equation $f : Y = XA$. Then $X$ causes $Y$ if and only if $A$ is present. One goal is to learn about $f$, the other is to learn about $A$--- a property that implies a reaction given a background model. 

## Identification

Last, *identification*--roughly whether you can nail the quantity of interest if you have enough data---is a problem for inference, but it is not a concern unique to experiments. You can have identification problems for causal estimands or descriptive estimands. And of course it bears repeating: even if a quantity is not identified, you can still learn about it!

Lets use these ideas to think through different uses of survey experiments.

# Survey experiments

As in Cyrus Samii's post, I think it's useful to distinguish between survey experiments "proper" and experiments that just happen to be delivered via surveys. 
I think when people complain about survey experiments they are commonly focusing on the former. The latter set really are just experiments though delivered in quite special conditions.

Let's think through different types of survey experiment, understood broadly.

## Information experiments

Information experiments are typically used for causal inference, not descriptive inference, whether or not they are delivered through a survey. In some cases these are almost indistinguishable from field experiments --- for instance if information is delivered in a way similar to treatments of interest and if outcomes are measured outside of the survey, for instance through measures of subsequent behaviors.  

## Priming experiments

### A priming experiment conducted for descriptive inference.

Say I am  interested in whether you know ($K$) that a weapon ($X$) was used in a crime ($Y$). Your knowledge is something I think you have or do not have and I want to know about it. I would love to just measure that evidence, but it is hard. 

So I show you a picture of the knife and I measure your reaction. I make inferences about the effect of the prime on your reaction (X on Y) in order to make inferences about your knowledge (K). The effect estimate is a diagnostic tool.  I make a causal inference in order to do descriptive inference. But I am clear: my interest is in your knowledge, it is not on the effect of seeing a knife on your stress levels. 

One implication of this is that I would be unhappy with this study if I found no evidence for a causal effect but in fact K = 1, or if I did find evidence but K = 0 for the simple reason that my interest in the causal effect is just instrumental here.

### A priming experiment conducted for causal inference.

But I might well be interest in a priming experiment specifically to make causal inferences. I am interested in whether being reminded of corruption by a politician makes you more likely to support the opposing party. I am interested in this because I think politicians or the media do this before elections and I am interested in understanding these effects. That's fine. I think sometimes people can trip up and mix up the effect of the prime with the effect of the thing being primed (e.g the effect of corruption itself). But with the focus on the effect of the prime itself this is a standard causal estimand inferred using an experiment, that may or may not just happen to be delivered using a survey.

## List experiments

### A list experiment conducted for descriptive inference.

You are interested in whether people think there is corruption (K) or not. In principle this is measurable, but it is hard to measure. You vary whether there is a long list or short list (X) and infer from the effects on the the count answers (Y) whether people think there is corruption or not. You are primarily interested in K; there is no independent interest here in how list length affects answer except for its role for descriptive inference.

### A list experiment conducted for causal inference.

I think this is not so common but you could imagine being interested in the effect of a long versus short list on whether people exhibit social desirability bias.


## Conjoints

[de la Cuesta et al](https://www.cambridge.org/core/journals/political-analysis/article/improving-the-external-validity-of-conjoint-analysis-the-essential-role-of-profile-distribution/B911EF14513292A24ECB4AC4BAA3FA6B) describe conjoints as 
 "a factorial survey experiment that is designed to measure multidimensional preferences". 
 
 Note the emphasis on measurement. I think their remit is a little broader though. Used for descriptive inference, but about more than preferences, for example they might also be used to study how people make classifications or understand concepts. But they might also be used when the estimand is causal. 


### Conjoints for descriptive inference.

IN the many cases in which the goal is to measure preferences, interpretations, of classification rules, conjoint experiments may be best thought of as focused on descriptive inference and using causal inference to make those descriptive inferences.


An example: say a bank uses a rule to decide whether to give loans or not. You want to figure out the rule. You do so using a conjoint to assess which profiles are more likely to get loans given different attributes. The estimand of interest is not a set of causal effects, it is a rule. But you try to figure it out by seeing whether notional features "affect" the classification. Two gains from recognizing that the goal is descriptive inference:

1.  you might figure out that that a more effective strategy is to look figure out the rule from archival sources, such as regulations or instructions to staff. Maybe it is measurable, in which case measure it.

2.  You might not fall into the trap of thinking the relation between feature values and outcomes corresponds to the causal effects of changing the feature (or confuse the direct/ controlled effect within the experimental regime with the average effect). This is a little trickier, but to think through a simple example. Say in truth we have $X_1 \rightarrow X_2 \rightarrow Y$, and $X_1$ affects $Y$ via $X_2$ but not conditional on $X_2$. Then a conjoint might pick up that $X_1$ is not part of the classification rule for $Y$ but wrong to think that actually changing $X_1$ will not affect how you actually get classified.

For another example, in [this](https://www.cambridge.org/core/journals/political-analysis/article/trading-liberties-estimating-covid19-policy-preferences-from-conjoint-data/71AB21F181572AF9C745E67B9DA796CD), together with colleagues we use a conjoint to measure policy preferences. We combine the conjoint results with a choice model to estimate ideal points. Although we use the language of effects a bunch we are interested in trying to measure something but are resorting to inference.

### Conjoints for causal inference

Even still I think it is possible that conjoints can be used also when the primary target is causal inference. Say you really are interested in whether the presence of a given feature on a list of features makes it more likely that the list will be selected. 

You might have an application where people are electing candidates and know nothing about the candidates other than what they get in a flyer. You want to know how features of the flyer affect the choice. Then you are pretty close to the conjoint. You are interested in the effect of the feature on behavior. You have to worry about external validity, is there too much control and all that, but these are common worries for any experiment.

This is the sort of setting discussed in [Bansak et al](https://www.cambridge.org/core/journals/political-analysis/article/using-conjoint-experiments-to-analyze-election-outcomes-the-essential-role-of-the-average-marginal-component-effect/0B7D820F9775C9B19D800BF9B088C358).

That's fine but Risk 2 above remains: the effect you are getting is the effect of the attribute on the list, not the average (total) effect of the attribute itself on the outcomes.  For example you might find that a a powerful candidate does well given different values of corruption (even for different distributions of corruption), but this does not give you the effect of power itself, since, after all, power corrupts. 