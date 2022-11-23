---
layout: page
permalink: /teaching/how-to-write
title: How to write
description: writing
nav: false
nav_order: 4
---

<strong>1 Sections</strong>

<strong>1.1 Front Matter</strong>
<ul>
 	<li><strong>Table of contents</strong>:
<ul>
 	<li>Have a table of contents.</li>
 	<li>Go two or at most three <strong>levels</strong> deep (so sections and subsections, but generally not subsubsections).</li>
 	<li>Use <strong>informative section headers</strong> so that readers can figure out the logical structure of the thesis from the table of contents.</li>
 	<li>Have your table of contents <strong>generated automatically</strong> and have it <strong>hyperlink</strong> to sections. Number all sections. In latex using \section{}; in R markdown using #, ## ; in Word using “Heading 1” “Heading 2” styles – and setting the number to be of the form 1, 1.1, 1.12, 1.2, 2 etc these all can be used to generate automatic table of contents. No handcrafting of numbering or of Tables of Contents.</li>
</ul>
</li>
 	<li><strong>Acknowledgements</strong>: You can include acknowledgements and thank colleagues and friends -- anyone who gave you support; normally this is added after a defense and before submission.</li>
 	<li><strong>Dedication</strong>: It's not uncommon to dedicate a thesis (or dissertation but not a paper) to someone.</li>
 	<li><strong>Abstract</strong>: You can have a short abstract (quarter page) <em>and</em> a longer executive summary (two pages). Abstracts should give (1) brief motivation (2) overview of strategy (3) main findings. People often use an abstract to report what they <em>did</em> but the most important purpose is to report what you <em>found</em>. Remember findings can be positive and negative--- if you find that the data simply does not support some intuitively plausible or commonly believed proposition that is big news; don’t bury that.</li>
</ul>
<strong>1.2 Introductions</strong>

Introductions should give a high level motivation, a brief description of what you will do, a summary of findings, and a clarification of contributions (why what you did matters or how it is innovative). Saying early on what your main findings or claims are is very important. Given the abstract, exec summary, and intro, the reader should have no doubt about where things are going by the time they get into it. Doing this lets readers evaluate your claims more quickly and more directly; it shouldn’t be a puzzle for the reader to figure out your conclusion and your key points should not come as a surprise in the last pages.

<strong>1.3 Theory Chapters</strong>

A good structure for a formal theory chapter is this:
<ol>
 	<li>Motivate the model. Why do we care?</li>
 	<li>Describe the model formally, this requires a full description of (a) the players – how many are they? What are their roles  (b) the strategies – what choices do they have (c) the preferences. In addition this may require a description of the sequence of moves and the information available to all players.</li>
 	<li>The game description should normally include all parameters of interest including any for which you plan to take comparative statics.</li>
 	<li>Provide key results in the form of formal propositions. Eg Proposition 1: “under the following conditions (eg all groups are of size ….) the following strategies (…) form an equilibrium.” Primary propositions often describe a particular equilibrium, describe the uniqueness or non-uniqueness of equilibriums, or describe properties of equilibriums.</li>
 	<li>Give formal statements of propositions on comparative statics (Y is higher when Xis high).</li>
 	<li>End the chapter by turning these comparative statics claims into empirical hypotheses</li>
 	<li>This leads naturally on to subsequent chapters.</li>
</ol>
<strong>1.4 Empirical Chapters</strong>

Whether empirical chapters are quantitative or qualitative they should lead off with a description of your <em>strategy</em>. What are you looking for to find evidence in favor or against a proposition. This strategy is often laid out in earlier chapters (for many people, in chapter 2) but there should still be a recap here. For a <strong>quantitative analysis</strong> the standard ordering (whether in one chapter or many) is:
<ol>
 	<li>Describe hypotheses</li>
 	<li>Describe measures</li>
 	<li>Describe tests</li>
 	<li>Describe core results</li>
 	<li>Interpret results substantively</li>
 	<li>Describe robustness</li>
 	<li>Describe any extensions</li>
 	<li>Draw overall inferences</li>
</ol>
If divided into chapters you might have 1-3 in one chapter, 4-5 in a second, 6-7 in a third and 8 in a conclusion.

For a <strong>qualitative thesis</strong> the elements might be:
<ol>
 	<li>Strategy</li>
 	<li>Description of case selection process</li>
 	<li>For each case:
<ol>
 	<li>General description</li>
 	<li>Describe how case relates to general model (eg discuss residuals, or the estimated contributions of different factors to the outcome in the case)</li>
 	<li>Discuss X and Y for case if relevant (are measures measuring what we thought they were)</li>
 	<li>Describe within case evidence (eg are we seeing what we expect to see if theory is right)</li>
</ol>
</li>
 	<li>Summary of evidence across cases, maybe gathered together in a single table.</li>
 	<li>Conclusion</li>
</ol>
These will vary depending on your project.

<strong>1.5 Conclusions</strong>

You can loosen up in the conclusion a bit to describe possible implications of your work in your domain or other domains. Draw linkages with other work and point to gaps in knowledge. While there is some value in speculation, this does not mean that you should make claims that are not supported by your analyses.

<strong>2 Presentation</strong>

<strong>2.1 Know your tools</strong>

Microsoft Word is fine for lots of writing but for technical writing it is worth investing is learning <a href="https://web.archive.org/web/20190730143111/http:/www.latex-project.org/">LaTeX</a> -- a free system for preparing documents. For real transparency it is good to integrate your analysis with your writing. This can be done in various ways but the simplest might be <a href="https://web.archive.org/web/20190730143111/http:/rmarkdown.rstudio.com/">Rmarkdown</a>. Be prepared to learn these new tools.

<strong>2.2 Style</strong>

Your aim in writing is to communicate your <em>results</em> as faithfully as possible not to communicate your <em>process</em> faithfully (of course you have to be transparent about how you did your analysis). It’s normal to go in circles as you develop your thinking on a topic but you do not have to bring the reader in the same circles. Instead try to think about what presentational structure would make it easiest for readers to understand your work quickly. <em>Never</em> try to make things seem more complicated than they are.

A couple of pointers on style:

<strong>Lots of signposting</strong>

Readers should know why they are reading any given section and any given paragraph with a section. Start off sections with a brief statement of the purpose of the section and end with a quick recap. Organize paragraphs so that each paragraph serves a clear function and readers can tell from the first line what the function is. Many readers won't read a section if they don't know  why they need to read it.

<strong>Keep writing tight</strong>

Remove unnecessary flab at the beginning of sentences: “In order to” “I am now going to talk about” “I would argue that”; “It should therefore come as no surprise that” à (try: “Unsurprisingly”)

Remove unoriginal flower: “much ink has been spilled,” “hardly a day goes past”

<strong>Formality:</strong>

Keep the writing formal: No contractions in formal writing (it’s, that’s, should've, etc)

<strong>Royal wheez:</strong>

Saying “we’ for a single authored piece can be a little weird. It works for sentences that implicates the reader or the disciplines (“we see from this figure…”, “we know that <em>X</em> causes <em>Y</em>”). For single authored pieces "I" usually works fine. Avoid "this paper argues." I argue.

<strong>Use the present tense when describing things being done in the text</strong>:

"I describe my strategy in Chapter 2 and my findings in Chapter 3." Not "I will describe my strategy in Chapter 2 and my findings in Chapter 3." And not "I described my strategy in Chapter 2 and my findings in Chapter 3."   Past tense of course find for past events: "I <strong>use</strong> information from interviews <strong>conducted</strong> in . . ."

<strong>Math: </strong>

Get math formatting right. In particular never start a sentence with math; always have math in italics. So not “x denotes commodities” but “We use <em>x</em> to denote commodities.” Use the equation editor in word or if you have a lot of math use <a href="https://web.archive.org/web/20190730143111/http:/www.latex-project.org/">LaTeX.</a>

<strong>Hyperbole:</strong>

Avoid superlatives: vast, massive, extraordinary

Remove; “necessarily” (“while we do not necessarily argue…”)

Remove: “important”, “importantly” (let the reader decide)

Don’t overclaim – if you are arguing that <em>X</em> causes <em>Y</em> don’t call this “my theory”; it is an empirical claim not a theoretical claim. Don’t use “prove” unless you mean an analytic proof – empirical tests never prove anything. Be especially careful about null results – a null result means that you cannot reject the null of no effect, not that you have proved that there is no effect.

<strong>Avoid common writing errors:</strong>

The past tense of lead is led, not lead

Get “affect” and “effect” right

Get “advise” and “advice” right

Get “its” and “it’s” right (hint: never use “it’s”; use “its” and “it is”)

“Question begging” is a technical term; use it if you know what it means; if you just mean “raises the question” say “raises the question.”

<strong>Other formatting</strong>

-Don't forget page numbers! Really.

-Most formatting, like font size and margin size, as well as citation style etc. are up to you, as long as you are consistent. However single or 1.5 spacing is easier on paper; and larger font is easier on the eyes. A good standard is 12 point font, 1.5 spacing, and moderate margins.

<strong>2.3 Tables</strong>
<ul>
 	<li>Tables and figures should be in the main body of the text, not at the end (unless they are only meant as extra material).</li>
</ul>
<ul>
 	<li>Tables and figures should be numbered and captioned/titled, in most cases. You can do automatic numbering word using “captions”, and in Latex using \caption{}</li>
</ul>
<ul>
 	<li>If it’s a table call it a table, don’t call it a figure</li>
</ul>
<ul>
 	<li>Tables and other output should NOT be presented as Stata output or other raw output.</li>
</ul>
<ul>
 	<li>The standard approach is to make a table where each regression is a column. One option is to use Stata function "outreg2," which can produce very high quality Word (or LaTeX) regression output quite easily. Similar equivalents in R (eg <a href="https://web.archive.org/web/20190730143111/http:/cran.r-project.org/web/packages/stargazer/vignettes/stargazer.pdf">http://cran.r-project.org/web/packages/stargazer/vignettes/stargazer.pdf</a>).</li>
</ul>
<ul>
 	<li>Coefficients should be arranged in rows with comprehensible and consistent variable names</li>
</ul>
<ul>
 	<li>standard errors should be shown in parentheses (or you should note what measure of uncertainty you are displaying if it is not standard errors)</li>
</ul>
<ul>
 	<li>include descriptive statistics like number of observations (N) and R-squared should be included.</li>
</ul>
<ul>
 	<li>Make sure to say what the dependent variables is</li>
</ul>
<ul>
 	<li>Useful also to show how a table result links to a hypothesis.</li>
</ul>
<ul>
 	<li>You do not however have to report everything in your tables. For example you do not have to report the values on all control variables if they are not of interest. Table writing is like writing – you should set the tables up so that they communicate the key information as clearly as possible.</li>
</ul>
<ul>
 	<li><strong>Precision</strong>: numbers should normally reported to two significant digits. Eg 0.12 not 0.000121313245</li>
 	<li><strong>Bottom line</strong>: It's often useful and legitimate to give the bottom line of a table at the bottom of the table: "Table shows that there is no evidence that democracy causes growth"</li>
</ul>
<strong>2.4 Figures</strong>

When possible use figures rather than tables. Figures can give the same information as tables but in a more immediate way. When they show distributions of individual data points they often provide much <em>more</em> information.

<strong>2.5 References</strong>

Use APSR citation style (<em>www.apsanet.org/portals/54/apsa%20files/publications/apsastylemanual2006.pdf</em>)

If working in rmarkdown or latex, use bibtex for this

