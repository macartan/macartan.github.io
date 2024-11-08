---
layout: page
permalink: /teaching/how-to-write
title: How to write
description: writing
nav: false
nav_order: 4
number-sections: true
---

<!-- Table of Contents -->
* TOC
{:toc}

# 1. Structure overview

Here is a standard structure for both a paper (sections) or  thesis (chapters).  This is a great structure especially for empirical papers.  You can of course deviate but only do so deliberately.  

1. **Introduction**: in which you get your readers on board 
2. **Theory**: in which you help readers see how your question relates to and can go beyond existing knowledge 
3. **Strategy**: in which you tell readers how you will answer the question, what data and answer strategies you will use
4. **Main results**: this is the heart of the paper / thesis
5. **Discussion / deepening**: in which you go beyond the core results often by (a) showing robustness (b) exploring mechanisms (c) examining heterogeneity (d) examining cases
6. **Conclusion**


# 2. Chapter types, section types

Here are further pointers on different types of chapters.

## Front Matter

A thesis typically has front matter. 

### Table of contents
  - Have a table of contents.
  - Go two or at most three **levels** deep (so sections and subsections, but generally not subsubsections).
  - Use **informative section headers** so that readers can figure out the logical structure of the thesis from the table of contents.
  - Have your table of contents **generated automatically** and **hyperlinked** to sections. Number all sections. 
    * In  latex using `\section{}` and `subsection`
    * In R markdown or quarto use `#`, `##` 


### Acknowledgements

You can include acknowledgements and thank colleagues and friends — anyone who gave you support; normally this is added after a defense and before submission.

### Dedication

It's not uncommon to dedicate a thesis (or dissertation, but not a paper) to someone.

### Abstract

You can have a short abstract (< quarter page) *and* a longer executive summary (two pages). 

Abstracts should give 

1. brief description of question and motivation
2. overview of strategy
3. very short summary of main findings. 

People often use an abstract to report what they *did*, but the most important purpose is to report what you *found*. Remember, findings can be positive and negative — if you find that the data simply does not support some intuitively plausible or commonly believed proposition, that is big news; don’t bury that.

## Introductions

Introductions should include:

 * a high-level motivation: readers should know from the first paragraph what question you hope to answer
 * a brief description of what you will do
 * a summary of findings
 * a clarification of contributions (why what you did matters or how it is innovative)
 * (possibly) a roadmap
 
 Saying early on what your main findings or claims are is very important. Given the abstract, executive summary, and intro, the reader should have no doubt about where things are going by the time they get into it. Doing this lets readers evaluate your claims more quickly and more directly; it shouldn’t be a puzzle for the reader to figure out your conclusion, and your key points should not come as a surprise in the last pages.

## Formal theory chapters

Here is a good structure for a formal theory (game theoretic) chapter:

1. Motivate the model. What question will the theory answer. Why do we care? What do we already know.
2. Describe the model formally. This requires a full description of (a) the players – how many are they? What are their roles?, (b) the strategies – what choices do they have?, (c) the preferences. Additionally, this may require a description of the sequence of moves and the information available to all players.
3. The game description should normally include all parameters of interest, including any for which you plan to take comparative statics.
4. Provide key results in the form of formal propositions. For example, Proposition 1: “Under the following conditions (e.g., all groups are of size …) the following strategies (…) form an equilibrium.” Primary propositions often describe a particular equilibrium, describe the uniqueness or non-uniqueness of equilibria, or describe properties of equilibria.
5. Give formal statements of propositions on comparative statics (e.g., Y is higher when X is high).
6. End the chapter by turning these comparative statics claims into empirical hypotheses.


## Empirical strategy chapters

Whether empirical chapters are quantitative or qualitative, they should lead off with a 
description of your *strategy*. What are you looking for to find evidence in favor or against a proposition? This strategy is often laid out in earlier chapters (for many people, in Chapter 2), but there should still be a recap here. For a **quantitative analysis**, the standard ordering (whether in one chapter or many) is:

1. Describe hypotheses and estimands.
2. Describe the population: what cases are you looking at and why.
3. Describe data / measures. Describe sources, measures, and transformations. You might show descriptive statistics here.
4. Describe analyses strategies. Provide justification and conditions required for valid inferences. Readers should be clear about how you will map from data you might see to inferences. This is as true for qualitative work as for quantitative work.


## Case study chapters

Be clear why you have a case study and what you want to do with it.

* Quick summary of why you have the case and what you hope to learn from it 
* Justify case selection: why this case? How does it relate to other possible cases? Clarify whether it is typical or atypical, a "most likely" case or "least likely" and so on. Your cases are probably not "ideal" cases so use the discussion of case selection as an opportunity to say what the likely implications of different features of a case are for inferences.
* Say what you are looking for in the case and what you will infer depending on what you find
* Describe sources
* General description of the case
* Specific findings relevant for theories
* Inferences



## Conclusions

You can loosen up in the conclusion a bit to describe possible implications of your work in your domain or other domains. Draw linkages with other work and point to gaps in knowledge. While there is some value in speculation, this does not mean that you should make claims that are not supported by your analyses.

Common sections:

* Recap of most important findings
* Caveats
* Implications
* New agendas


## Appendices

Things that live in appendices:

* Reconciliation reports describing deviations from analysis plans and analyses implemented. [More.](https://book.declaredesign.org/lifecycle/realization.html#reconciliation) 
* Proofs of formal results
* Robustness checks
* Tabular analogues of figures in the main text

If you have appendices:

* Keep them short
* Sections should be lettered not numbered: Appendix $A$, Appendix $B$...
* Every section should be referenced in the main text


# 3. Writing tools

Microsoft Word is fine for lots of writing, but for technical writing it is worth investing in learning [LaTeX](http://www.latex-project.org/) — a free system for preparing documents. For real transparency, it is good to integrate your analysis with your writing. This can be done in various ways, but the simplest might be [quarto](https://quarto.org/) or [Rmarkdown](http://rmarkdown.rstudio.com/). Be prepared to learn these new tools.

# 4. Style

* Your aim in writing is to communicate your *findings* as faithfully as possible, not to communicate your *process* faithfully (of course, you have to be transparent about how you did your analysis). It’s normal to go in circles as you develop your thinking on a topic, but you do not have to bring the reader in the same circles. Instead, try to think about what presentational structure would make it easiest for readers to understand your work quickly. 
* *Never* try to make things seem more complicated than they are.
* Keep sentences short.

## Pointers on style:

Please:

- **Lots of signposting**: Readers should know why they are reading any given section and any given paragraph within a section. Start off sections with a brief statement of the purpose of the section and end with a quick recap. Organize paragraphs so that each paragraph serves a clear function and readers can tell from the first line what the function is. Many readers won't read a section if they don't know why they need to read it.

   * Social science writing is not like literary writing
      * You don't build up and then reveal the findings at the end
      * You give the findings up front and then provide the evidence to support it
      * You should *not* assume that readers read linearly: they treat this as a compendium not a poem
      * So  readers need to know what function every section has in the thesis and what function every paragraph has in a section



- **Keep writing tight**: Remove flab at the beginning of sentences: “In order to” “I am now going to talk about” “I would argue that”; “It should therefore come as no surprise that” (if you must, try “Unsurprisingly”); "I do not necessarily mean ...").
 Remove unoriginal flower: “much ink has been spilled,” “hardly a day goes past.”

- **Formality**: Keep the writing formal. No contractions in formal writing (it’s, that’s, should've, etc).

- **Voice**: Saying “we” for a single-authored piece can be a little weird. It works for sentences that implicate the reader or the disciplines (“we see from this figure…,” “we know that *X* causes *Y*”). For single-authored pieces, "I" usually works fine. Avoid "this paper argues." Instead, say, "I argue."

- **Use the present tense when describing things being done in the text**: "I describe my strategy in Chapter 2 and my findings in Chapter 3." Not "I will describe my strategy in Chapter 2 and my findings in Chapter 3." And not "I described my strategy in Chapter 2 and my findings in Chapter 3." Past tense is of course fine for past events: "I *use* information from interviews *conducted* in . . ."

- **Math**: Get math formatting right. In particular, never start a sentence with math; always have math in italics. So, not “x denotes commodities” but “We use *x* to denote commodities.” Use the equation editor in Word or, if you have a lot of math, use [LaTeX](http://www.latex-project.org/).

- **Hyperbole**: Avoid superlatives: vast, massive, extraordinary.




- **Modesty**: 

  * Don’t overclaim — if you are arguing that *X* causes *Y*, don’t call this “my theory”; it is an empirical claim, not a theoretical claim. 
  * Don’t use “prove” unless you mean an analytic proof — empirical tests (almost) never prove anything. 
  * Be especially careful about null results – a null result means that you cannot reject the null of no effect, not that you have proved that there is no effect. 
  * Go easy on “important,” “importantly” (let the reader decide).
  * Don't say "no measurable / detectable effect" if you just mean that you have not detected one.
  * "Necessary" is a very strong claim ("this necessarily leads to...") 

- **Common errors**:
  - The past tense of lead is led, not lead.
  - Get “affect” and “effect” right.
  - Get “advise” and “advice” right.
  - Get “its” and “it’s” right (hint: never use “it’s”; use “its” and “it is”).
  - “Question begging” is a technical term; use it if you know what it means.
  - Get "fewer" and "less" right.




## Signposting examples

**1. Introduction**
I show that natural resource abundance causes conflict. In section 2 I provide the logic. In section 3 I describe my strategy. Sections 4 and 5 give results and section 6 discusses implications.

**2. Theory**
Three theories predict an adverse effect of natural resource abundance. I describe each in turn, I then discuss strategies to distinguish between these accounts.

**3. Strategy**
I estimate the effect of natural resources on conflict using qualitative and quantitative strategies. I describe each in turn.
...

**5.1 Sierra Leone Case study**
I first present general background about this case, I then explore whether there is evidence in support of each of mechanisms 1, 2, and 3.


# 5. Tables and Figures

## Table or Figures?

* When possible use figures rather than tables. 

* Tables and figures should usually be in the main body of the text, not at the end.

* Tables and figures should be numbered and captioned/titled, in most cases. You can do automatic numbering word using “captions”, and in Latex using `\caption{}`

* Tables and other output should NOT be presented as Stata output or other raw output. There are many tools to produce nice output without a lot of work (`outreg2` in Stata, `texreg`, `stargazer` in `R`, but many more)


## Tables and Figures

* Coefficients should be arranged in rows with comprehensible and consistent variable names

* Standard errors should be shown in parentheses (or you should note what measure of uncertainty you are displaying if it is not standard errors)

* Include descriptive statistics like number of observations (N) and R-squared should be included.

* Make sure to say what the dependent variables is

* Precision: numbers should normally reported to two significant digits. e.g.  0.12 not 0.000121313245

* Bottom line: It’s often useful and legitimate to give the bottom line of a table at the bottom of the table: “Table shows that there is no evidence that democracy causes growth”


# 6. References

General pointers

* The bibliography should contain an entry for every work cited---including websites---and should contain entries *only* for work cited.
* There are *lots* of rules around correct  formatting in the text and at the end. Plus there are different sets of rules. You should outsource this work to a tool not lose time getting this right.
* References in sentences either have the year in parentheses or the year and last name in parentheses. They should include page references when possible.
* For references to specific claims include page numbers.
* Only include references you have read. 
* Check your biases: are you citing mostly friends, coethnics, men, seniors... are you giving credit where credit is due? 

In markdown enter like this:

* `@putnam2000bowling` said some great stuff
* Putnam said some great stuff `[@putnam2000bowling]`
* `@putnam2000bowling [p. 7]` said some great stuff
* Putnam said some great stuff `[@putnam2000bowling, p. 7]`

[More](https://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)



## Grabbing references

I pull from google scholar mostly

* I do a search. e.g.  https://scholar.google.de/scholar?hl=en&as_sdt=0%2C5&q=putnam+bowling+alone&btnG=
* Then select the [bib](https://scholar.googleusercontent.com/scholar.bib?q=info:nQoGffkGw4MJ:scholar.google.com/&output=citation&scisdr=CgVA0Gv4EMHY0N6r9Ww:AAGBfm0AAAAAYA6u7WxVGiL8mR2PhobB31vo77xrrm3e&scisig=AAGBfm0AAAAAYA6u7eMD3UwBA3Q4An8W5YtfQrP8GTO6&scisf=4&ct=citation&cd=-1&hl=en) reference.
* And save that into a `.bib` text file


```
@incollection{putnam2000bowling,
  title={Bowling alone},
  author={Putnam, Robert D},
  booktitle={Culture and politics},
  pages={223--234},
  year={2000},
  publisher={Springer}
}
```

```
@online{NYT,
  author = {{New York Times Editorial Board}},
  title = {Hong Kong Crackdown Is an Early Test for Biden},
  year = 2021,
  url = {https://www.nytimes.com/2021/01/24/opinion/hong-kong-arrests.html},
  urldate = {2021-01-25}
}
```


Other tools include Zotero, Endnote, Mendeley

Principle is that you should spend a little time figuring out how to make this work and then not spend much time on it.

# 7. Footnotes


* Footnotes generally preferred to endnotes.
* Use footnotes sparingly.
* Citations generally do not go in footnotes but in the main text.
* Put singly at the end of a sentence, after the period.`^[Like this]`
* Put singly at the end of a sentence, after the period.^[Like this]
* Not like^[No!] that, or like this^[No].


# 8. Actually writing

## Aim

Nearly everyone finds writing hard and many find *some* parts of writing impossible.

Aim should be to make the process easy. 

* Principle: Know **what** you want to say before you start writing

    * **Chapter abstracts**: write these first; these help you get clear on the point/purpose of every chapter
    * Use outlines: every paragraph should be making a point. An outline can have the main point of each paragraph in a single line.
    
* Principle: Know **how** you want to say it before you start writing.
    * It can be incredibly useful to present your argument to others to figure out what about it people find easy or hard and how to deliver a point most effectively. 

## Keep moving

* Principle: Balance easy and hard writing.

   * Some parts take a long time to write. If you are stuck switch to easier bits and sleep on the harder bits. But be sure to return to them.

* Principle: Write a bad draft and then improve.
    * Don't spend a lot of time early on getting your style right; focus instead on getting the substance down
    * Work in layers---try to get a full draft 

* Principle: Write from the inside out. Get your core results, write them up, then write deepening sections and design section, then intro and conclusion. Exception: write abstracts first.

* Principle: Allocate chunks of time to tasks. Figure out what chunk length is best for you: 30 minutes? 3 hours? Protect the time and assign specific tasks for that chunk.

## Fine tuning

* Principle: use advice from friends and colleagues well

    * Ask others to read your work and be clear whether you want feedback on substance or style
    * No point getting help with fine editing if content is likely to change
    * Feedback that seems wildly irrelevant to you can also be informative as it shows what parts of your argument people have a hard time following
    
* Principle: Don't be afraid to cut.

    Most writing has flab. Near the end as you go through you can ask, for each paragraph: Is this paragraph adding content? Would the thesis be any weaker without it? If not then cut, not matter how lovely the writing/
