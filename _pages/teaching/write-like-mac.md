---
layout: page
permalink: /teaching/write-like-mac
title: write-like-mac
nav: false
nav_order: 4
name: write-like-mac
description: >-
  Draft and revise academic prose in this clipped, findings-first style: clear
  structure, heavy signposting, formal US English. Scholarly text: sober modest
  claims. Recommendation letters: more effusive, superlatives welcome. Use when
  writing papers, theses, memos, reports, recommendation letters, README prose,
  or when the user asks to write like Mac or write-like-mac.
---

Distilled from [How to write](https://macartan.github.io/teaching/how-to-write). Prefer later edits the user adds to this file over this baseline.

Save this page and point your AI at it (for example, if you use Cursor, put it under `~/.cursor/skills/write-like-mac/SKILL.md`).

## Core aim

Communicate **findings** faithfully, not the **process** of arriving at them. Make it easy for readers to understand the work quickly. Never make things seem more complicated than they are.

**Scholarly prose** is clipped and factual: short sentences, concrete nouns, plain verbs. State claims up front; let specifics do the work. **End with a point**—what the reader should take away—not only procedural wrap-up.

**Recommendation letters** are different: more effusive and direct. Superlatives and words like *important* are fine when they describe the candidate or their work. Still anchor praise in concrete facts; still end with a point.

## Default structure (empirical work)

1. **Introduction** — question, approach, findings, and contribution early
2. **Theory** — relate the question to existing knowledge
3. **Strategy** — data, design, cases
4. **Main results** — the heart of the piece
5. **Discussion** — robustness, mechanisms, heterogeneity, cases
6. **Conclusion** — recap, caveats, implications, new agendas

For single-authored work, **I** is fine; **we** only when it implicates the reader or discipline (*we see from this figure…*). Prefer *I argue* over *this paper argues*.

## Findings first

- State main claims early (abstract, intro, section openers)
- Do not build suspense and reveal conclusions only at the end
- Every section must justify itself on first contact; readers may not read linearly
- Abstracts emphasize what was **found**, not only what was **done** (nulls are findings)

## Signposting

Social science writing is not literary writing. Signpost heavily.

- Open each section with its purpose; close with a brief recap when useful
- **One core idea per paragraph.** The first line signals that idea; split if there are two
- **No repetition** unless adding new information. Cut *as mentioned above*, *it is important to note that*
- Cut throat-clearing (*In order to*, *I am now going to talk about*). Short transitions that signpost are fine (*Several take-aways follow.* · *I highlight two.*)
- Roadmap example: *I show that X. Section 2 provides the logic. Section 3 describes the strategy. Sections 4–5 give results; Section 6 discusses implications.*

## Sober claims (scholarly prose)

Understated and precise. Let substance carry weight.

- Do not inflate scope, novelty, or certainty
- Ban *important* / *importantly* as empty intensifiers (also *crucial*, *critical*, *key* when they add no content)
- Avoid *proves*, *demonstrates conclusively*, *necessarily*, *always*, *transformative*, *groundbreaking*, *novel* unless strictly warranted
- Prefer concrete nouns and verbs over stacked modifiers
- Hedge when appropriate: *may*, *can*, *suggests*, *is consistent with*, *under these conditions*
- Report null and negative results plainly

When editing scholarly text, strip empty intensifiers and replace with specifics. Do **not** apply these sobriety rules to recommendation letters.

## Style rules

| Do | Avoid |
|----|--------|
| Short sentences, tight prose | Flab, flower (*much ink has been spilled*) |
| Formal register; no contractions | *it's*, *that's*, *should've* |
| Present tense for what the text does | *I will describe…* / *I described…* for structure |
| Past tense for past events | |
| Modest claims; substance not hype | Superlatives in papers; exaggeration |
| Concrete nouns and verbs | Empty *important*, *crucial*, *key*, *critical* |
| Correct *affect*/*effect*, *fewer*/*less*, *its*/*it's* | *Prove* for empirical claims; *no detectable effect* when you mean *not detected* |
| US spelling | UK spellings unless requested |
| Italics for math symbols in prose | Starting a sentence with math |
| First, second (not firstly, secondly) | *aforementioned*; repeated points across paragraphs |
| `$…$` / `$$…$$` for math | `\(` `\)` `\[` `\]` except multiline align |
| Reader-facing claims only | Author notes in the manuscript |

**Manuscript vs notes to the author.** Running text and captions are for the reader. Production notes belong in chat or a memo. Never write *there is no need for a figure*, *I dropped…*, *we could add…*, *as discussed*, or *TODO* into the paper.

**No comma-*and* second clause.** Do not join two independent clauses with a comma plus *and*. Split into two sentences, or keep one subject and two verbs. Lists of nouns are fine.

Bad: *Two comparisons can each produce an apparent gain, and they are easy to confuse.*
Good: *Two comparisons can each produce an apparent gain. They are easy to confuse.*

**Emphasis:** italics sparingly; never ALL CAPS. Do not call an empirical claim *my theory*. Failure to reject the null is not proof of no effect.

## Math (Markdown / Quarto / Rmd)

- Inline: `$x$`. Display (single line):

$$
y = \beta x + \varepsilon
$$

- Multiline / aligned: `\begin{align}...\end{align}` or `$$\begin{aligned}...\end{aligned}$$`
- Introduce symbols in prose: *We use* $x$ *to denote…*
- Probability operator: `\Pr(` not bare `Pr(` in math mode

## References and links

- Verify every citation before using it; do not invent sources
- Include a URL when one exists (prefer DOI or other stable links)
- If a source cannot be verified, flag it for the user rather than citing it

## By section

**Introduction.** Motivation and question; methods preview; findings; contribution; optional roadmap. Open on a concrete problem or stakes, not a literature review. End with a roadmap when useful.

**Theory.** Motivate the argument; formalize if needed; state propositions; end with testable implications. Setup and results stay separate; flag assumptions; state limitations explicitly.

**Strategy (quantitative).** Hypotheses and estimands → population/cases → data and measures → analysis strategy.

**Case studies.** Justify selection; say what you look for and what you infer; distinguish typical/atypical or most-/least-likely cases.

**Conclusion.** Recap, caveats, implications, gaps. Land a closing point—what the reader should believe or do differently—not a summary alone.

**Tables and figures.** Prefer figures when possible; keep them self-explanatory. Coefficients in rows; SEs in parentheses; report *N*, *R²* when relevant; about two significant digits. Bottom line in the caption when helpful.

**Abstracts.** Problem or context → what you show → implication or scope.

**Essays and commentary.** Shorter paragraphs; one idea each; metaphor sparingly; close with a call to action for the field.

**Short memos.** Clipped factual tone: claim first, evidence second. Enumerate stakes (*I see two gains.*). End with a point for the decision, not only next steps.

## Recommendation letters

Letters are more effusive than scholarly text: warm, forceful advocacy grounded in specifics.

- Strong support in the first sentence (*I write in strong support of…*, *I recommend in the strongest terms*)
- Superlatives are welcome when fair; *important* / *crucial* / *key* are fine for the candidate or their work
- Pair praise with evidence (papers, designs, fieldwork, collegial behavior)
- Cover fit: benefit to the candidate and, when relevant, to the home unit
- Structure: opening → candidate → project/research → fit (enumerate stakes) → close with recommendation, offer of more information, and a substantive final point
- Fellowship/postdoc letters are often one page; faculty job letters are longer, with named papers and pipeline

Example phrases (adapt; do not copy blindly):

- *We were excited to hire him as about the only candidate I have ever encountered who did deep ethnographic field work and advanced formal theory and was skilled in network analysis.*
- *It has been wonderful having him in our group and we would re-hire him in a flash.*
- *I have no doubt he will be an inspiring teacher and a fabulous colleague.*

## Hand-holding quantitative walks

When the reader must follow an algorithm on numbers, walk the arithmetic. Do not only report the result.

- Show the calculation: $\delta_{+}=\min(1-0.2,0.6)=0.6$, not only $\delta_{+}=0.6$
- Name both branches (plus and minus)
- Say who is assigned, and to what
- Keep the updated state explicit after each step
- Give probabilities as a computed ratio, then the fraction
- One step per stretch of prose; finish the pair before the next
- Captions may restate the assignment consequence of each $\delta$

When editing a numerical walk-through, keep that structure. Tighten grammar only; do not collapse a worked example into a one-line result.

## Phrases that fit

Use when natural, not as filler:

- *Several take-aways follow.* / *Three implications follow.*
- *In the remainder of the [paper/section], I…*
- *The utility of this result depends on the plausibility of…*
- *Observe that…* / *Note that…* / *It follows that…*
- *This is distinct from… though that's part of it.*
- *Less well understood is…* / *This leaves open…*
- *The key feature here is not X but rather Y.*
- *Put differently: can…?*
- *We highlight three.* / *First,… Second,… Third,…*
- *In practice, however, a common strategy is…*

Subsection titles can be claims (*Misunderstood selection.*), not only labels.

## Phrases to avoid (scholarly prose)

- Empty *important* / *importantly* / *crucially* / *it is worth noting that*
- *As mentioned above* / *It goes without saying* / *In this context* (when empty)
- *This paper contributes to the literature by…* → *I show / I establish / We describe*
- *It is well known that…* → cite or show
- *Interestingly,* / *A growing body of literature*
- Vague *implications for policy and practice* without saying what follows
- Author notes in the manuscript; comma-*and* second clauses

## Drafting process

1. Clarify claim, audience, and genre before polishing style
2. Draft inside out: core results → strategy → intro and conclusion
3. Write a bad draft, then tighten
4. Cut flab and de-duplicate
5. Keep author notes out of the manuscript

## Output checklist

**All genres**

- [ ] Main claim visible without reading to the end
- [ ] Section and paragraph signposting present
- [ ] One core idea per paragraph; no repetition or empty phrases
- [ ] No contractions; formal but plain language
- [ ] No comma-*and* second clause
- [ ] Structure matches genre
- [ ] Closing point present
- [ ] No author notes in the manuscript

**Scholarly prose only**

- [ ] Claims calibrated; no empty intensifiers; sober tone
- [ ] Math uses `$` / `$$`
- [ ] Quantitative walks show arithmetic, both branches, assignment, and updated state
- [ ] References verified; URLs where available

**Recommendation letters only**

- [ ] Warm, effusive advocacy backed by specifics
- [ ] Enthusiastic recommendation plus a substantive closing point
