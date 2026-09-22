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
  Overleaf stub; outputs/ for rerun products vs assets/ for stable inputs; data
  kept outside the AI workspace). Do not create or restructure folders until
  the user approves. Use when asked to make_project, make-project, set up a
  project folder, scaffold a paper repo, or check whether a project matches
  the standard.
---

# make-project

Save this page and point your AI at it (for example, if you use Cursor, put it under `~/.cursor/skills/make-project/SKILL.md`).

**What.** Help set up or clean a research project folder that is safe for an AI to access, with memos for onboarding, a GitHub stub for analysis and writing, and optionally an Overleaf stub for TeX coauthoring.

**When.** Starting or auditing a paper/project folder. Related: [analysis-skill](/teaching/skills/analysis-skill) for `analysis.qmd`; [write-like-mac](/teaching/skills/write-like-mac) for prose; [review-my-paper](/teaching/skills/review-my-paper) for manuscript review (findings can go in `memos/review.md` once a review exists).

## Posture (read first)

This skill is **mostly feedback and options**, not silent scaffolding.

1. **Ask questions before doing anything.** Gather intent before inspecting or changing files.
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
| Project stem | Naming key used across stubs |
| Structure | Canonical tree (gh + Overleaf) |
| File roles | Memos and stub files; **outputs vs assets**; Overleaf sync flow |
| Security | Data and confidential material |
| Layout rules | Deep trees; one current copy; **archive + here::** |
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

The **project stem** is a short, filesystem-safe identifier for the project. Use it consistently in folder and file names.

Example: a TikTok project has stem `tiktok` (same as the project name in that case).

Typical uses:

| Use | Pattern |
|-----|---------|
| GitHub stub folder | `project_stub_gh` or `<stem>` / repo name |
| Overleaf stub folder | `project_stub_overleaf` or `<stem>_overleaf` |
| RStudio project | `<stem>.Rproj` |
| Analysis naming (analysis-skill) | `<stem>_analysis.qmd` when stem-prefixed names are used |

Ask for the stem early if it is not obvious from the folder name. Prefer one stem everywhere rather than mixing nicknames.

---

## Structure

Canonical layout. Names are filesystem-safe. Human-readable titles noted where they differ.

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
│   ├── overlay/                      # optional; may be present
│   ├── <stem>.Rproj
│   ├── paper.qmd
│   ├── analysis.qmd                  # aligned with analysis-skill
│   ├── presentation.qmd              # revealjs
│   └── README.md                     # includes path to data (outside this tree)
└── project_stub_overleaf/            # Overleaf / TeX coauthoring stub (optional)
    ├── paper.tex
    ├── appendix.tex
    └── assets/
        └── bib.bib                   # plus synced figures/tables and other compile inputs
```

The GitHub stub folder may use the repo name instead of the literal `project_stub_gh`. The Overleaf stub may use `<stem>_overleaf` instead of `project_stub_overleaf`. Internal layout matters more than the literal folder name; keep stem-based naming consistent when you choose a variant.

**Not in this tree:** respondent-level data, credentials, restricted IRB materials, or other confidential files. Record their path in `README.md`.

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
| `README.md` | How to open the project; **path to data outside** this tree |
| `outputs/` | **Rerun products:** tables, figures, and other objects produced when code is rerun. Analysis writes here. |
| `assets/` | **Stable inputs:** `bib.bib`, static images for compilation, other files that mostly do **not** change on rerun. Not for regenerated `tab_*.tex` / `fig_*.png`. |
| `saved/` | Intermediate `.rds` (or similar) when useful alongside `outputs/` |
| `lib/` | Cited papers / readings as used |
| `code/` | Extra scripts outside the main `analysis.qmd` spine |
| `archive/` | Older versions only |
| `overlay/` | Optional |

### Overleaf stub (`project_stub_overleaf/`)

| Path | Role |
|------|------|
| `paper.tex` | Main TeX manuscript |
| `appendix.tex` | Appendix |
| `assets/` | **Compiled sync location** for Overleaf: receives copies from gh `outputs/` (rerun products) **and** gh `assets/` (stable inputs such as `bib.bib`). TeX `\includegraphics` / `\input` paths point here. |

**Flow (do not invert):**

1. Analysis writes regenerated tables/figures to gh `outputs/`.
2. Stable inputs live in gh `assets/`.
3. Overleaf `assets/` is fed by syncing **both** gh `outputs/` and gh `assets/` into that single TeX-facing folder.
4. Overleaf `assets/` is **not** the primary place analysis writes; it is a destination for compile/sync.

### `outputs/` vs `assets/` in the GitHub stub (do not blur)

| Folder | Contains | Changes when analysis is rerun? |
|--------|----------|----------------------------------|
| `outputs/` | Tables, figures, analysis objects written by code | Yes — regenerate here |
| `assets/` | Bib, static images, stable compile inputs | Mostly no |

Same distinction as in analysis-skill. Overleaf’s `assets/` is a different role: a merged sync sink for TeX, not the analysis write target.

---

## Security and confidentiality

1. **Data and sensitive material must not be available to the AI.** Keep them elsewhere; put the path in `README.md`.
2. Do not copy microdata, identifiers, credentials, or restricted documents into the AI-accessible root or into chat.
3. If confidential material may already be in the workspace, **alert the user** and do not dig into those files unless explicitly authorized for a local, non-uploading task.
4. Never upload project data or manuscripts to an external model without permission.

---

## Layout rules

- **Deep rather than wide.** Few files per folder; nested by job.
- **Only one current copy** of each key document. No `paper_final.qmd` beside `paper.qmd`.
- **Archive** older versions as `YYYYMMDD_name.xxx` under `archive/`.
- Live file = plain name; history only in `archive/`.

### Archiving and paths (`here::`)

When moving a live file into `archive/` (or relocating folders), **paths must still work from the new location**.

- Prefer the R [**here**](https://here.r-lib.org/) package: resolve project-root-relative paths with `here::here(...)` (and Quarto/R scripts that call `here`) so roots stay valid after moves.
- Avoid hard-coded absolute paths and fragile `../` chains that break when a file’s depth changes.
- After an archive or restructure, check that data paths in `README.md`, analysis housekeeping, and any TeX `\input` / figure paths still resolve.
- When proposing archive/cleanup options, call out path risk and favor `here::`-based roots in the recommended fix.

---

## Make (propose, then wait)

After questions, propose—do not create yet—something like:

1. AI-accessible root name, **project stem**, and parent path; confirmation that data stay outside.
2. `memos/` with the four starter files (thin placeholders only).
3. GitHub stub folders, including clear `outputs/` vs `assets/`.
4. Thin stubs: `<stem>.Rproj`, `paper.qmd`, `analysis.qmd` (pointer or spine from analysis-skill), `presentation.qmd`, `README.md` with a **Data** path placeholder outside the tree.
5. Optional: Overleaf stub (`paper.tex`, `appendix.tex`, `assets/bib.bib`) and whether to include `overlay/` and `saved/`.
6. Path convention: prefer `here::` for R/Quarto roots so later archives do not break relative paths.

Present as **options** when more than one layout is reasonable (e.g. stub folder name, whether to add Overleaf, whether to migrate an existing mess). **Create files only after the user approves** an option.

Do not invent results, citations, or fake project history.

---

## Check (report, then propose)

Inspect against the standard. Return findings and cleanup options. Restructure only after approval.

### Checklist

- [ ] AI-accessible root vs data location; README records external data path
- [ ] Project stem clear and used consistently (`.Rproj`, stub names if stem-based)
- [ ] No apparent confidential/microdata/secrets in the AI tree (if suspected: alert)
- [ ] `memos/` with `onboarding.md`, `notes_for_coauthors.md`, `to_do.md` (and `review.md` if a review exists)
- [ ] Stub has `paper.qmd`, `analysis.qmd`, `presentation.qmd`, `<stem>.Rproj`, `README`
- [ ] `outputs/` used for rerun products; `assets/` for stable inputs (flag swaps or dumps in the wrong place)
- [ ] If Overleaf stub present: `paper.tex`, `appendix.tex`, `assets/`; TeX pulls from Overleaf `assets/`; that folder is sync-fed from gh `outputs/` + gh `assets/`, not the analysis write target
- [ ] Expected folders present as needed: `archive/`, `lib/`, `code/`, `assets/`, `outputs/`, `saved/`
- [ ] Deep rather than flat; one current copy of each key document; dated archives
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
- Treat Overleaf `assets/` as the analysis write target (it is a sync/compile sink)
- Create multiple live versions of the same paper or analysis file
- Invent substantive paper content when scaffolding
- Quietly ignore suspected confidential material—alert the user
- Archive or move files in ways that break relative paths without fixing roots (`here::`)
