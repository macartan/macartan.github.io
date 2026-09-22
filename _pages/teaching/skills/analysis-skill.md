---
layout: page
permalink: /teaching/skills/analysis-skill
title: analysis-skill
nav: false
nav_order: 4
name: analysis-skill
description: >-
  Write a self-contained Quarto analysis.qmd (HTML, toc, code folding) with
  housekeeping, helpers, data prep, one subsection per table/figure, appendix
  then extras, and export of rerun products to outputs/ (tables, figures,
  analysis objects). Use assets/ only for stable inputs (bib, static images).
  Structure chunks so a locked draft can later become a replicateEverything
  study repo. Use when creating or rewriting analysis.qmd, data_prep.qmd,
  paper-replication notebooks, or when the user mentions analysis-skill,
  structure_analysis, make_*/format_*, or replicateEverything-compatible
  analysis files.
---


# analysis-skill

Save this page and point your AI at it (for example, if you use Cursor, put it under `~/.cursor/skills/analysis-skill/SKILL.md`).

Author a **single self-contained `analysis.qmd`** that is the working analysis for a paper.

Do **not** create a `replicateEverything` repo, a parallel `replication.yml`, or a one-file-per-table layout on day one. Brief background: `analysis.qmd` is the day-one working analysis. [replicateEverything](https://replicate-anything.github.io/replicateEverything/articles/contributing-principles.html) is a later packaging standard for replication repos (locked code, `replication.yml`, study layout). Do not jump to that structure prematurely.

Write the qmd so a **later** helper can extract a locked version into `code/`, `outputs/`, and `replication.yml`. Identifiability lives in the qmd (chunk labels, object names, `rep:` markers). Yaml is for a frozen deposit, not a moving draft.

If a `replicateEverything` skill or `AI.md` is available, read it before promising deposit-repo details. This skill governs the **authoring** layout only.

## Map of this file

| Section | Use it for |
|---------|------------|
| Output files | What to create (and what not to) |
| Quarto YAML | HTML options |
| Section order | Notebook spine |
| Item anatomy | One table/figure unit |
| Code style | Readable code, packages, helpers, hand-run tests |
| Data (hard) | Privacy and Stata NA quirks |
| Later conversion | Locked deposit only |

A human can skim **Section order** and **Item anatomy**. An agent should follow the full spine end to end.

---

## Output files

| File | When |
|------|------|
| `analysis.qmd` | Always. One notebook for the paper. Project identity is the **folder name**, not a stem inside this file. |
| `data_prep.qmd` | When cleaning is substantial (multiple sources, long recodes). The analysis file still has a data section that runs or sources prep. |
| `outputs/` | Tables, figures, and other objects **produced when code is rerun** (e.g. `tab_<n>_<handle>.tex`, `fig_<n>_<handle>.png`, analysis objects). Save rerun products here. |
| `assets/` | Things that mostly **do not** change when code is rerun: `bib.bib`, static images for paper compilation, other stable inputs. Do **not** put regenerated table/figure files here. |
| `outputs/analysis.Rdata` | Always at the end: tables/figures as named objects (in `outputs/`, not `assets/`) |

Do not write `replication.yml` unless the user asks for a locked deposit.

## Quarto YAML

Use HTML with `toc`, `code-fold`, `code-tools`, and `embed-resources`.

## Section order

1. Housekeeping (`pacman`, switches, labels, seed, paths)
2. Helper functions (mechanics only; specifications stay at the item)
3. Data (`make_prep_*`; separate `data_prep.qmd` if substantial)
4. Paper tables/figures — one subsection per item
5. Appendix — own section; each item a subsection
6. Additional analyses — only if clearly relevant; parallel outcomes together
7. Export — write regenerated tables/figures and `outputs/analysis.Rdata` to `outputs/` (not `assets/`)

## Item anatomy

Each item has:

1. An HTML `<!-- rep: -->` comment (`id`, `type`, optional `parents` / `paper` / `label` / `description`)
2. A `make-<id>` chunk that creates `<id>_df` (or models)
3. A `format-<id>` chunk that creates display object `<id>`

Do not use a displayed `rep` code fence.

Omit `parents` on roots. Never write `parents: []`.

Naming: `tab_<n>_<handle>` / `fig_<n>_<handle>` in paper order.

## Code style

Readable by humans first.

- Comment clearly
- Use functions for efficiency, but avoid deep wrapping of functions in functions
- Expose code where key decisions are made (for example the analytic model)
- Separate `make_*` from `format_*`
- **Hand-run and tests.** Aim so a user can run the notebook up to some point, then execute a particular analysis interactively (not always possible; aim for it). Prefer entry points that are one-liners—especially for batch helpers. When you introduce a function, put a small test or demo call immediately after it (commented out is fine) so readers can see it in action—for example, after `implement_analyses`, generate a tiny dataset and run `implement_analyses(temp_df)`.
- Clustered OLS: current CRAN `estimatr` with `lm_robust(..., clusters = cluster_id, se_type = "stata")` (`"stata"` is faster than default HC2)
- HTML model tables: prefer `texreg::htmlreg(..., doctype = FALSE)` (works well with `lm_robust`); wrap with `knitr::asis_output()`
- LaTeX table/figure files for the paper: `texreg::texreg()` (and figure writes) into `outputs/`, not `assets/`
- Do not use `modelsummary` for these tables
- Compatible with replicateEverything later; do not ship `run_replication()` in the analysis file

## Data (hard)

Never print or upload respondent-level rows or IDs. Aggregates only.

Treat Stata `x != k` as true when `x` is NA.

## Later conversion

Harvest `rep` markers and `make-*` / `format-*` chunks into `replication.yml` and `code/<id>.R` only after the analysis is locked. Deposit-repo mapping (later, locked drafts only) may live in a companion `reference.md` next to this skill when present.
