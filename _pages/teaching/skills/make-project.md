---
layout: page
permalink: /teaching/skills/make-project
title: make-project
nav: false
nav_order: 4
name: make-project
description: >-
  Ask first, then give feedback and propose options to set up or clean a
  research project folder against Macartan's standard layout (AI-safe root with
  memos; GitHub stub with paper.qmd, analysis.qmd, presentation.qmd; optional
  Overleaf stub with figs_tabs/; outputs/ for rerun products vs assets/ for
  stable inputs; data kept outside the AI workspace). Do not create or
  restructure folders until the user approves. Use when asked to make_project,
  make-project, set up a project folder, scaffold a paper repo, or check
  whether a project matches the standard.
---


# make-project

Save this page and point your AI at it (for example, if you use Cursor, put it under `~/.cursor/skills/make-project/SKILL.md`).

**What.** Help set up or clean a research project folder that is safe for an AI to access, with memos for onboarding, a GitHub stub for analysis and writing, and optionally an Overleaf stub for TeX coauthoring.

**When.** Starting or auditing a paper/project folder. Related: [analysis-skill](/teaching/skills/analysis-skill) for `analysis.qmd`; [write-like-mac](/teaching/skills/write-like-mac) for prose; [review-my-paper](/teaching/skills/review-my-paper) for manuscript review (findings can go in `memos/review.md` once a review exists).

## Posture (read first)

This skill is **mostly feedback and options**, not silent scaffolding.

1. Gather missing intent before proposing changes. Read-only inspection is fine when the user has supplied a path and asked for a check.
2. Prefer **findings → options → approval** over creating or moving folders.
3. **Do not** jump straight into creating directories, rewriting trees, or mass moves.
4. **Wait for explicit user approval** before any file-system changes (mkdir, move, delete, overwrite).

### Workflow

| Step | Do |
|------|----|
| 1. Gather intent | Make vs check (or both as advice only); path; constraints (name, existing mess, what must stay) |
| 2. Inspect | Only if checking or the user gave a path—read layout lightly; do not restructure |
| 3. Findings | What fits, what is missing, what looks risky (especially data/confidential material) |
| 4. Propose options | Two or three concrete cleanup/setup choices; trade-offs in one line each |
| 5. Wait | Apply changes **only** after the user picks an option (or edits it) |

If the user already answered intent and path in the same message, do not re-ask those points—still propose before changing the filesystem unless they clearly said *go ahead and create/apply*.

---

## Map of this file

| Section | Use it for |
|---------|------------|
| Posture | Ask first; propose; wait |
| Mode | Make vs check (as advice modes) |
| Project stem | Naming key for folders / `.Rproj` (not inside `analysis.qmd`) |
| Structure | House-default tree (gh + Overleaf) |
| File roles | Memos and stub files; **outputs vs assets**; Overleaf `figs_tabs/` |
| Security | Data and confidential material |
| Layout rules | Coherent grouping; one current copy; **Git, archive + here::** |
| Make (propose) | What a setup option may include |
| Check (report) | Checklist and report format |

---

## Mode

Clarify make vs check up front (ask if unclear).

| Mode | Meaning | Default agent behavior |
|------|---------|------------------------|
| **Make** | New or empty project | Propose a target tree and starter files; create only after approval |
| **Check** | Existing project | Inspect, report gaps, propose cleanup options; change only after approval |

---

## Project stem

The **project stem** is a short, filesystem-safe identifier for the project. Use it consistently in **folder and `.Rproj` names**. Project identity for analysis is the **folder name**; the working notebook is always `analysis.qmd` (no stem inside that filename).

Example: a TikTok project has stem `tiktok` (same as the project name in that case).

| Use | Pattern |
|-----|---------|
| Project / folder name | Often equals the stem (e.g. `tiktok`) |
| GitHub stub folder | `project_stub_gh` or `<stem>` / repo name |
| Overleaf stub folder | `project_stub_overleaf` or `<stem>_overleaf` |
| RStudio project | `<stem>.Rproj` |
| Analysis file | Always `analysis.qmd` (not `<stem>_analysis.qmd`) |

Ask for the stem early if it is not obvious from the folder name. Prefer one stem everywhere rather than mixing nicknames.

---

## Structure

House layout. Treat this as a default, not a universal requirement: preserve a coherent existing structure when changing it would add churn without a concrete benefit. Names are filesystem-safe. Human-readable titles are noted where they differ.

```text
project_name/                         # AI-accessible project root (often = stem)
├── memos/
│   ├── onboarding.md                 # get an AI up to speed
│   ├── notes_for_coauthors.md        # title: "notes for coauthors"
│   ├── to_do.md
│   └── review.md                     # after a review has been conducted
├── project_stub_gh/                  # GitHub repo: analysis + writing
│   ├── archive/
│   ├── lib/                          # papers / library PDFs as used
│   ├── code/                         # extra scripts (not the main analysis spine)
│   ├── assets/                       # stable inputs: bib.bib, images/, fixed compile inputs
│   ├── outputs/                      # tables, figures, objects produced when code is rerun
│   ├── saved/                        # intermediate saved rds or similar (optional companion to outputs/)
│   ├── <stem>.Rproj
│   ├── paper.qmd
│   ├── analysis.qmd                  # aligned with analysis-skill
│   ├── presentation.qmd              # revealjs
│   └── README.md                     # includes path to data (outside this tree)
└── project_stub_overleaf/            # Overleaf / TeX coauthoring stub (optional)
    ├── paper.tex
    ├── appendix.tex
    ├── assets/                       # stable inputs synced from gh assets/ (e.g. bib)
    │   └── bib.bib
    └── figs_tabs/                    # figures/tables synced from gh outputs/
```

The GitHub stub folder may use the repo name instead of the literal `project_stub_gh`. The Overleaf stub may use `<stem>_overleaf` instead of `project_stub_overleaf`. Internal layout matters more than the literal folder name; keep stem-based naming consistent when you choose a variant.

**Not in this tree:** respondent-level data, credentials, restricted IRB materials, or other confidential files. Document how authorized users configure the data path. Do not put a sensitive absolute path, username, credential, or restricted server detail in a public README; use a redacted locator, environment variable, or ignored local configuration where appropriate.

---

## File roles

### Memos (`memos/`)

| File | Role |
|------|------|
| `onboarding.md` | Purpose, key paths, conventions, status, what an AI should not touch |
| `notes_for_coauthors.md` | Log of notes and changes (*notes for coauthors*) |
| `to_do.md` | Open tasks |
| `review.md` | Internal review once conducted |

### GitHub stub

| Path | Role |
|------|------|
| `paper.qmd` | The paper |
| `analysis.qmd` | Working analysis; follow [analysis-skill](https://macartan.github.io/teaching/skills/analysis-skill) |
| `presentation.qmd` | Revealjs presentation |
| `<stem>.Rproj` | RStudio / Posit project file |
| `README.md` | How to open the project; safe instructions for configuring the data path outside this tree |
| `outputs/` | **Rerun products:** tables, figures, and other objects produced when code is rerun. Analysis writes here. |
| `assets/` | **Stable inputs:** `bib.bib`, static images for compilation, other files that mostly do **not** change on rerun. Not for regenerated `tab_*.tex` / `fig_*.png`. |
| `saved/` | Intermediate `.rds` (or similar) when useful alongside `outputs/` |
| `lib/` | Cited papers / readings as used |
| `code/` | Extra scripts outside the main `analysis.qmd` spine |
| `archive/` | Meaningful snapshots: submissions, shared/received versions, or other identified states |

### Overleaf stub (`project_stub_overleaf/`)

| Path | Role |
|------|------|
| `paper.tex` | Main TeX manuscript |
| `appendix.tex` | Appendix |
| `assets/` | Stable inputs for TeX (e.g. `bib.bib`), synced from gh `assets/` |
| `figs_tabs/` | Figures and tables for TeX, synced from gh `outputs/`. TeX paths for regenerated products point here. |

**Flow (do not invert):**

1. Analysis writes regenerated tables/figures to gh `outputs/`.
2. Stable inputs live in gh `assets/`.
3. Sync gh `outputs/` → Overleaf `figs_tabs/`; sync needed gh `assets/` (e.g. bib) → Overleaf `assets/`.
4. Overleaf `figs_tabs/` and `assets/` are **not** where analysis writes; they are compile/sync destinations.

### `outputs/` vs `assets/` in the GitHub stub (do not blur)

| Folder | Contains | Changes when analysis is rerun? |
|--------|----------|----------------------------------|
| `outputs/` | Tables, figures, analysis objects written by code | Yes — regenerate here |
| `assets/` | Bib, static images, stable compile inputs | Mostly no |

Same distinction as in analysis-skill. On Overleaf, regenerated products land in `figs_tabs/`; stable inputs in `assets/`.

---

## Security and confidentiality

1. Store respondent-level and sensitive data outside folders the AI can browse as project material. Analysis code may read an external path when the user authorizes local processing.
2. Classify access: public/non-sensitive material may be handled normally; sensitive but locally authorized material gets minimum-necessary access and aggregate-only output; restricted or unauthorized material is not inspected; credentials and direct identifiers are never exposed.
3. Do not copy microdata, identifiers, credentials, or restricted documents into the AI-accessible root or into chat.
4. If confidential material may already be in the workspace, **alert the user** and do not inspect it unless explicitly authorized for the local task.
5. Local reading is distinct from external transmission. Never upload project data or manuscripts to an external service without permission.

---

## Layout rules

- Group files by job, but add nesting only when it improves navigation or access control. Avoid both crowded roots and needless directory depth.
- **Only one current copy** of each key document. No `paper_final.qmd` beside `paper.qmd`.
- Use Git for routine source history. Use `archive/` for meaningful snapshots such as submissions, externally shared versions, received files, or states that must remain easy to identify outside Git.
- Live file = plain name. Name archived snapshots `YYYYMMDD_name.xxx` or with another unambiguous version label.

### Archiving and paths (`here::`)

When relocating live folders, paths must still work. An archived snapshot need not remain executable unless reproducibility of that snapshot is an explicit requirement.

- Prefer the R [**here**](https://here.r-lib.org/) package: resolve project-root-relative paths with `here::here(...)` (and Quarto/R scripts that call `here`) so roots stay valid after moves.
- Avoid hard-coded absolute paths and fragile `../` chains that break when a file’s depth changes.
- After a restructure—and after archiving when the snapshot is meant to run—check that configured data paths, analysis housekeeping, and any TeX `\input` / figure paths still resolve.
- When proposing archive/cleanup options, call out path risk and favor `here::`-based roots in the recommended fix.

---

## Make (propose, then wait)

After questions, propose—do not create yet—something like:

1. AI-accessible root name, **project stem**, and parent path; confirmation that data stay outside.
2. `memos/` with the starter files that have an immediate role; do not create empty placeholders merely to complete the tree.
3. GitHub stub folders, including clear `outputs/` vs `assets/`.
4. Thin stubs: `<stem>.Rproj`, `paper.qmd`, `analysis.qmd` (pointer or spine from analysis-skill), `presentation.qmd`, `README.md` with a **Data** path placeholder outside the tree.
5. Optional: Overleaf stub (`paper.tex`, `appendix.tex`, `assets/bib.bib`, `figs_tabs/`) and `saved/` when needed. Add other folders only when their role is defined.
6. Path convention: prefer `here::` for R/Quarto roots so later archives do not break relative paths.

Present as **options** when more than one layout is reasonable (e.g. stub folder name, whether to add Overleaf, whether to migrate an existing mess). **Create files only after the user approves** an option.

Do not invent results, citations, or fake project history.

---

## Check (report, then propose)

Inspect against the standard. Return findings and cleanup options. Restructure only after approval.

### Checklist

- [ ] AI-accessible root vs data location; README safely explains external data-path configuration without exposing credentials or sensitive infrastructure details
- [ ] Project stem clear and used consistently (`.Rproj`, stub names if stem-based); analysis file is plain `analysis.qmd`
- [ ] No apparent confidential/microdata/secrets in the AI tree (if suspected: alert)
- [ ] `memos/` with `onboarding.md`, `notes_for_coauthors.md`, `to_do.md` (and `review.md` if a review exists)
- [ ] Stub has `paper.qmd`, `analysis.qmd`, `presentation.qmd`, `<stem>.Rproj`, `README`
- [ ] `outputs/` used for rerun products; `assets/` for stable inputs (flag swaps or dumps in the wrong place)
- [ ] If Overleaf stub present: `paper.tex`, `appendix.tex`, `assets/`, `figs_tabs/`; TeX figs/tabs from `figs_tabs/`; sync from gh `outputs/` → `figs_tabs/` and gh `assets/` → Overleaf `assets/`; neither is the analysis write target
- [ ] Expected folders present as needed: `archive/`, `lib/`, `code/`, `assets/`, `outputs/`, `saved/`
- [ ] Files grouped coherently without needless depth; one current copy of each key document; meaningful snapshots archived; routine history in Git
- [ ] `.gitignore`, package environment, generated-output/versioning policy, and access instructions fit the project
- [ ] Paths robust under archive/move (favor `here::`); no broken relative roots after past moves
- [ ] `analysis.qmd` compatible with analysis-skill (or gaps noted)

### Report format

```markdown
# Project check: [path]

**Mode:** check (advice)
**Overall:** fits / mostly fits / does not fit

## Alerts
[Confidential or data-in-workspace concerns, or None.]

## Findings
- ...

## Options
1. [Minimal cleanup] …
2. [Full align to standard] …
3. [Leave as-is / defer] …

## What already looks right
- ...
```

Wait for the user to choose an option before applying file-system changes.

---

## Do not

- Create, move, or delete project folders/files before the user approves
- Place or request data inside the AI-accessible project root
- Put regenerated tables/figures in gh `assets/` (use gh `outputs/`)
- Treat Overleaf `figs_tabs/` or `assets/` as the analysis write target (they are sync/compile sinks)
- Create multiple live versions of the same paper or analysis file
- Invent substantive paper content when scaffolding
- Quietly ignore suspected confidential material—alert the user
- Archive an executable snapshot or move live files in ways that break required paths without fixing roots (`here::`)
