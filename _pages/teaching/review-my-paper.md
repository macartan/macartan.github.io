---
layout: page
permalink: /teaching/review-my-paper
title: review-my-paper
nav: false
nav_order: 4
name: review-my-paper
description: >-
  Review a paper (usually Macartan's own) for substance, literature, facts,
  claims vs analysis, code, and language. Produces big / middle / small points
  plus a punch list. Use when asked to review my paper, critique a manuscript,
  referee a draft, pre-submit review, internal review, or similar. Default is
  self-review before journal submission, not a public referee report.
---

# review-my-paper

Internal review of a manuscript. Default: Macartan's own papers, before sending to a journal or coauthors. The output is a usable review plus a punch list, not a free-form essay.

Save this page and point your AI at it (for example, if you use Cursor, put it under `~/.cursor/skills/review-my-paper/SKILL.md`).

Source for the critique stance: [How to critique](https://macartan.github.io/teaching/how-to-critique). Language bar: `write-like-mac`.

## Warnings (do these first)

**Never upload a manuscript to an AI system without permission.** Local files in the workspace may be read. Do not paste the paper into an external model, third-party review site, or another chat unless the author has said that is allowed.

**Never upload data to an AI without permission.** Do not attach, paste, or send respondent-level files, extracts, identifiers, or raw tables to any model API. If code and data are on this machine and permission is given to *run locally*, run locally. In the conversation, report **aggregates only** (coefficients, CIs, *N*, grouped percentages). Do not print `head(df)`, dump data frames, or include IDs, names, or other individual records.

If either permission is missing, say so and stop that part of the work. Review the text you are allowed to see; skip data/code execution.

---

## Map of this file

| Section | Use it for |
|---------|------------|
| Start here | Two questions before any review |
| Stance | What a useful review is |
| Who does what | AI tasks vs human tasks |
| Workflow | Order of work |
| Required checks | References, literature, facts, claims, code, language |
| Output | Big / middle / small points + punch list |
| Working checklist | Themes from How to critique |
| Do not | Common review failures |

A human can skip to **Output** to see the deliverable, or **Who does what** to assign work. An agent should follow **Start here → Workflow → Required checks → Output**.

---

## Start here

Do not begin the review until these are answered. If the user already stated them, do not re-ask.

Ask:

> Before I start, can you tell me (a) what journal you have in mind (b) whether you want to do light revisions or are open to major revisions?

Also confirm, if not already clear:

- Path to the manuscript (and, if relevant, code and data).
- Permission to read the manuscript in this session.
- Permission to run code locally on data (yes / no / not available).

**Journal** sets the bar (identification, contribution, length, audience). **Revision appetite** caps advice: if light, do not propose a new design, a new question, or a rewrite of the theory. Flag fatal problems either way; do not hide them. If the appetite is light, mark big structural fixes as *park for later* rather than smuggling them in as copy-edits.

Then work. Do not wait for extra preferences.

---

## Stance

The job is to make the paper better and to say clearly what it does and does not establish. It is not to display the reviewer's cleverness.

- Summarize the contribution **as you see it**, then assess. A short summary often reveals whether the finding is actually a finding.
- Speak to the paper's own question. Do not ask the authors to write a different paper.
- Organize comments by **theme**, not by page order, for anything above a small point.
- If you flag an error, get to the **so what**. An error that does not move a claim is a small point.
- Name strengths. State what you know now that you did not know before reading.
- Be generous on intent: missing citations, missing robustness, missing ethics discussion. Do not assume bad faith. Still say the gap.
- Tone: you would not be embarrassed if the review became public.
- Fresh perspective is useful: what is this a case of? If you had to take a policy action on this evidence, where would you pause? Keep the paper's language; do not talk past it.
- Point to relevant work the paper missed. Do not pad with self-citation.
- Say what to **cut**. Reviews that only add material are not useful.
- Calibrate claims to evidence. Null is not "no effect." Policy implications must follow from the results.

---

## Who does what

### AI should do (and report)

These are expected every time the files are available. Do them; do not only recommend that a human do them.

- Extract the paper's claims (main, secondary, policy, novelty).
- Check every reference (existence, authors, year, title, venue, DOI/URL). Flag working papers that now have a published version, broken links, and citations that do not support the sentence they sit in.
- Search for prominent missing literature on the same question, treatment, or estimand.
- Check factual claims (institutional facts, dates, magnitudes attributed to others, what cited papers actually found).
- Map each major empirical or theoretical claim to the analysis that is supposed to justify it. Flag gaps, overclaiming, and underclaiming.
- If code is available: read it. If data may be used locally: run what is needed for verification; compare paper numbers to output; review sample construction, identification in the code, clustering/SEs, and obvious pipeline errors.
- Language pass against `write-like-mac` (findings first, signposting, sober claims, US English, no empty intensifiers, verified citations).
- Produce the review in the output format below, including a punch list.

### Human should do (do not fake these)

- Grant permissions for manuscript and data.
- Choose journal and revision appetite.
- Judge taste, contribution, and whether the paper is a paper for that journal.
- Decide which big points to act on; the punch list is advice.
- Confirm that flagged literature actually belongs (AI will over-include).
- Ethical or fieldwork judgments that are not in the text.
- Final call on identification: whether you believe the design.
- Anything that would require uploading files or data you have not authorized.

In the review, keep a short **For the human** list: items the AI cannot settle.

---

## Workflow

1. **Permissions and the two questions.** Stop if manuscript permission is missing.
2. **Read the whole paper once** for the question, approach, findings, and contribution. Write the one-paragraph summary before listing faults.
3. **Run the required checks** below. Work from claims, not from a line-by-line edit of the prose.
4. **Select themes.** A useful review has a few big points, not twenty. Use the working checklist to choose themes; do not dump the checklist into the review.
5. **Calibrate to journal and appetite.** APSR/AJPS/QJE is a different bar from a field journal or a handbook chapter. Light appetite: prioritize errors, overclaims, and cheap fixes.
6. **Write the review** in the output format. No fluff. Every comment: location, problem, why it matters, what to do.
7. **Punch list last.** Actionable, ordered, checkable. Tie each item to a big, middle, or small point.

---

## Required checks

Do all of these. If a check cannot be done, say why (no bibliography, no code, no data permission).

### 1. References: correct and up to date

- Every cited work exists. Authors, year, title, venue match.
- URLs/DOIs work where given. Add a note if a cited working paper has a stable published version.
- In-text citations match the bibliography (year, author count, missing entries, orphans).
- Do not invent citations. If a source cannot be verified, flag it.

### 2. Literature connections

- The sentence the citation supports is actually what that work claims.
- Positioning is accurate: not "first" if it is not; not a straw man of prior work.
- Prominent work on the same treatment, outcome, or estimand is not missing.
- Theory is consistent with findings the paper itself cites.
- Connections can be wrong in either direction: over-claiming novelty, or citing a paper as support when it cuts against the claim.

### 3. Factual claims

- Check dates, places, legal/institutional facts, and quantitative facts attributed to the world or to other papers.
- Check that summaries of others' results have the right sign, estimand, and scope.
- Flag anything that cannot be checked from the text plus public sources.

### 4. Claims justified by the analysis

- List the paper's claims (abstract, intro, results, conclusion, policy).
- For each: what result, table, figure, or derivation is supposed to bear it?
- Flag: claim with no result; result that does not imply the claim; wrong estimand; mechanisms asserted not tested; policy implications that do not follow; "no effect" from a noisy null; robustness that does not address the actual threat.
- Ask whether the empirical model matches the theory, and whether rival interpretations are admitted.

### 5. Code and data (when available)

Permission gate applies.

- Read analysis code against the paper's design: sample, treatment, outcomes, controls (pre-treatment only?), clustering, weights, missing data.
- If local run is allowed: regenerate key numbers; catch stale hardcoded results.
- Pipeline: merges, filters, unit of analysis, silent row loss. Do not print microdata.
- If code exists but data may not be used, review the code and say which claims were not re-executed.

### 6. Language (`write-like-mac`)

Read `write-like-mac` and apply it. This is a self-review default.

Flag (with a fix when cheap):

- Findings buried; process narrated instead of results stated.
- Missing signposting; two ideas in one paragraph; repetition; throat-clearing.
- Empty intensifiers (*important*, *crucial*, *key*); overclaiming (*prove*, *novel*, *always*).
- Contractions; UK spelling; mystery-novel structure; "this paper argues."
- Math/punctuation conventions from that skill.
- Tables/figures that are not self-explanatory.

Do not turn the review into a style essay. Language issues are usually **small** unless they hide the contribution or overclaim the result. Overclaiming is a **big** point.

---

## Output

No preamble. Use these headings. If a section is empty, write *None.*

```markdown
# Review: [title or filename]

**Journal bar:** [journal or "unspecified"]
**Revision appetite:** light / open to major
**Files:** manuscript [path]; code [path or none]; data [not used | local run only | none]
**Permissions:** manuscript [yes/no]; data [yes/no/n/a]

## What I take the paper to do

[One paragraph: question, approach, findings as you read them, contribution, main strengths. Then one or two sentences of overall assessment: what would worry an editor at this journal.]

## Big points

[Few. Each is a theme that could change what the paper is, what it claims, or whether it is ready. For each:]

**B1. [Theme]**
- Where: [section / result]
- Problem: [specific]
- So what: [what claim moves]
- Do: [concrete fix, calibrated to revision appetite]

## Middle points

[Real issues that do not redefine the paper: a robustness, a measure, a hole in the literature, a table that misleads, a hypothesis that is not implied. Same four bullets. Label M1, M2, …]

## Small points

[Bullets. Ambiguities, typos, citation repairs, language, estimation nits, pointers to other work. Location first.]

## Punch list

[Ordered. Checkable. The author should be able to work down it.]

- [ ] P1 — [action] (from B1)
- [ ] P2 — …
- [ ] … small items at the end, batched if many (e.g. "fix bibliography items X, Y, Z")

## Checks

| Check | Result |
|-------|--------|
| References | [ok / issues; 1–2 lines] |
| Literature | |
| Facts | |
| Claims vs analysis | |
| Code / data | [done / skipped: reason] |
| Language | |

## For the human

[Judgment calls only. If none: None.]
```

**Size.** Prefer 3–6 big+middle themes together. Small points can be longer. Do not bury a fatal identification problem in small points.

**Voice of the review.** Clipped, specific, decent. Use *you* or *the paper*. Quote enough to locate the issue.

---

## Working checklist

Use this while reading to **choose themes**. Do not paste it into the review. From [How to critique](https://macartan.github.io/teaching/how-to-critique).

**Theory.** Internally consistent? Consistent with past findings? Novel or surprising? Excluded pieces plausibly unimportant? General or specific—should it draw on a more general theory?

**Theory → hypotheses.** Is the theory needed to generate them? More hypotheses than tested? Actually implied (non-monotonicities, multiple equilibria)? Mechanisms specified? Heterogeneous effects implied?

**Hypotheses.** Bundled (two or three in one)? Falsifiable?

**Design.** Population and conditions of interest? Measures match the theory? Empirical model consistent with theory? Mechanisms identified? Replicable? Rival interpretations?

**Analysis.** Reverse causality, omitted variables, pre-treatment controls vs matching? Poorly identified claims flagged? Robust to model, subset, period, controls? SEs use the design / clustering? Results intelligible (fitted values, graphs)? Can a null be read as only weak effects?

**Other bias.** Pre-analysis / fishing? Measurement error correlated with outcomes? Spillovers? Compliance? Hawthorne? Treatment the only systematic difference? Does remaining bias cut for or against the hypothesis?

**Explanation.** Does the evidence support *this* causal account? Mechanisms examined or examinable? Distinct observable implications?

**Policy.** Do implications follow? Other effects if implemented? Tested directly? Overselling or underselling?

---

## Do not

- Start without journal, revision appetite, and manuscript permission.
- Upload manuscript or data without permission.
- Dump microdata or identifiers into the chat.
- Write a discussant talk (three clever asides). This is a review with a punch list.
- Ask for a different research question.
- Confuse "I would have written a different paper" with a defect in this one.
- Pad with optional citations, especially the reviewer's own.
- Report every checklist item. Select.
- Soften a fatal problem because appetite is light. Label it; park the rewrite if asked.
- Rewrite the paper in the review. Point, then punch-list the fix.
- Pretend a literature or fact check was done if it was not.
