---
name: cv-generator
description: Generates and updates CVs and tailored resumes from career evidence in YAML. Use when creating a general CV or tailoring a resume to a job description or job posting URL.
---

# CV generator

Treat the active project repository as the project root, even when an explicit input is elsewhere. Paths under `build/` are relative to the directory containing this skill file; paths under `docs/` are relative to the project root. Resolve relative input paths from the project root and use absolute paths when rendering.

## Prerequisites

- `uv` and access to a uv-managed Python 3.13 environment with `rendercv[full]==2.8` for rendering. Use `PyYAML==6.0.3` when parsing or validating YAML with Python. Reuse an existing environment when possible; do not modify global Python installations.
- A PDF inspection tool that can render every page to an image and report page count, such as `pdftoppm` and `pdfinfo` from Poppler. If unavailable, use an equivalent local tool or report that visual verification could not be completed.
- For a job posting URL, a browsing or web-reading tool capable of retrieving the complete description. If it cannot be read, request the text.

Check prerequisites before preparing artifacts. If a required tool is unavailable, report the blocker rather than claiming completion.

## Source and workflow

- Resolve the career evidence file before any document preparation: use the user-provided input path if supplied; otherwise use `career.yaml` in the project root if present, then `references/career.yaml` in the project root. If an explicit path is missing or unreadable, report that path and stop; do not fall back. If neither default exists, stop early and report that no career YAML input was found and request a file path.
- The resolved input is the source of career evidence. This guide defines how agents turn it into CVs and application resumes.
- Prepare RenderCV YAML directly from the source and render it locally. Do not recreate a permanent generator script, hardcoded content table, or separate CV highlight field.
- The maintained skill files are `SKILL.md` and `README.md`; the project career source is maintained separately. Keep intermediates in ignored `build/` and final documents in ignored `docs/cv-generator/` at the repository root.
- Resolve the skill and repository root paths, including when reached through a symlink. Use absolute paths in RenderCV commands to avoid its input-relative path resolution.
- Keep career evidence, client records, and application materials local. Do not upload, publish, submit applications, or contact employers without explicit authorization.

## Evidence and wording

- Read the current career source before preparing a document. Every claim must be supported by the resolved career input or an explicit user correction.
- Preserve employer IDs and project `employer_id` references. Resolve selected work projects to real employers and role dates; keep personal projects independent.
- Do not invent or inflate technologies, ownership, leadership scope, achievements, business impact, or metrics. Preserve reported-versus-measured and estimated qualifications; distinguish individual contributions from team results.
- Use employer-position dates for employment tenure and project dates for project timelines. If conflicting evidence affects a claim, ask for clarification.
- Preserve month-level dates as quoted `YYYY-MM` strings. Use `present` only for ongoing work; completed projects need an end date and `status: completed`.
- If available, read and follow the `humanizer` skill when drafting or revising reader-facing career prose. Keep supported facts, names, numbers, dates, and actors; remove filler and repeated claims.
- Write achievement bullets in the past tense, including completed achievements within ongoing roles. Keep titles, skill labels, and dates as recorded.
- Record new facts and corrections in the existing source objects. Do not rewrite evidence merely to match a job description.

## General CV rules

### Profile and section order

- Read name, email, website, and social networks from the top-level source fields. Include a location only when the source or user supplies one.
- Base the summary on the source's top-level `summary`, editing for concise, factual wording. Do not keep an independent canned summary in code or this guide.
- Omit a headline unless the user requests one.
- Use sections in this order: Summary, Experience, Skills, Education, Certifications. Add projects only when requested; do not silently turn the general CV into a tailored application.

### Employers and tenure

- Require each employer's `cv` field to be a boolean. Include `true` employers and omit `false` employers.
- Show each included company once, in reverse order of company start date.
- Within each company, sort positions by start date descending. Display only the current or most recent role and its location; omit prior-role lists and role-progression summaries.
- Company tenure starts at the earliest position start date. It ends at `present` if any position is ongoing; otherwise use the latest position end date. Preserve the individual role dates in the resolved career input.
- Use the recorded title for the most recent position unless the user requests a different display title.

### Achievement selection

- Use only existing employer `star_stories` and position `responsibilities` for company bullets.
- Prioritize STAR stories in source order. Use the title for context and the complete result for the outcome, preserving metric qualifications. Do not render situation, task, or action as extra bullets by default.
- Follow with responsibilities from positions ordered newest first, preserving each role's responsibility order.
- Select two to five distinct, nonempty achievement bullets per company. Normalize whitespace and compare case-insensitively, ignoring a final period, when removing exact duplicates.
- Do not concatenate repetitive titles and results without editing. Keep all facts from a selected result while removing wording that repeats its title.
- Validate story titles and results as nonempty strings and responsibilities as lists of nonempty strings. Included companies need at least one valid position and two distinct achievements. Report missing evidence clearly; never silently omit a company or invent replacement bullets.
- If an employer lacks responsibilities or STAR stories but its existing work projects contain the needed evidence, record supported responsibilities in the existing role before preparing the document. Do not create another curation field.

### Skills, education, and certifications

- Read Skills directly from the top-level `skills` mapping. Preserve category and item order, use each category key as its label, and join its list of skills with commas for RenderCV's `details` field.
- Require nonempty category labels and nonempty lists of nonempty skill strings. Do not introduce hardcoded categories or technologies.
- Include all source education. Preserve institution, area, degree, location, and start/end dates in source order.
- Include all source certifications in the general CV, preserving name, issuer, issue date, and credential ID where supplied. Map `issued_date` to RenderCV's `date` and show the issuer and optional credential ID in the entry summary.
- Omit certification expiration dates from the general CV as requested, while preserving them in the source. Do not claim that expired credentials are currently valid.

## Shared design

Use this RenderCV configuration for new documents unless the user requests a change. Preserve document-specific approved design changes when updating an existing application. Use the English locale.

```yaml
design:
  theme: sb2nov
  page:
    top_margin: 0.55in
    bottom_margin: 0.55in
    left_margin: 0.5in
    right_margin: 0.5in
    show_top_note: false
  typography:
    alignment: left
    line_spacing: 0.48em
    font_size:
      body: 10pt
      name: 26pt
      section_titles: 12pt
  header:
    space_below_name: 0.5cm
    space_below_connections: 0.55cm
  section_titles:
    space_above: 0.7cm
    space_below: 0.25cm
  sections:
    space_between_regular_entries: 0.7em
locale:
  language: english
```

## Preparing and rendering a general CV

1. Read the resolved career input, validate its structure and the selected evidence, and apply the general CV rules above.
2. Write a RenderCV input with top-level `cv`, `design`, and `locale` fields to `build/rendercv.yaml`. Populate `cv.sections` with the prepared entries. This file is a disposable build artifact, not another source of career facts.
3. From the skill directory, set `REPO_ROOT` to the absolute repository root and create `"$REPO_ROOT/docs/cv-generator"`. Render:

   ```sh
   uv run --python 3.13 --with 'rendercv[full]==2.8' rendercv render \
     "$PWD/build/rendercv.yaml" \
     --pdf-path "$REPO_ROOT/docs/cv-generator/cv.pdf" \
     --typst-path "$PWD/build/cv.typ" \
     --output-folder "$PWD/build/rendercv" \
     --dont-generate-html --dont-generate-markdown --dont-generate-png
   ```

4. If another PDF destination is requested, substitute its absolute path for `--pdf-path`, create its parent directory, and keep intermediates under `build/`. Do not write into the website's public directory unless explicitly requested.
5. Verify the PDF exists and is nonempty, then perform the checks below. Stop and report rendering errors without claiming success.

## Tailored resumes

- Obtain the complete job description and identify the company, role, requirements, and preferences. If a job URL cannot be read reliably, request pasted text; a title alone is insufficient.
- Assess fit and ATS coverage against the job description using supported evidence and report gaps. These assessments do not apply to routine general CV regeneration.
- Select and edit claims using source evidence. Use job keywords only where supported. Keep general CV flags and evidence independent of job-specific tailoring.
- Propose changes to established employer, education, or certification selection rules. Exclude expired certifications by default from tailored resumes, or label them accurately when historical relevance matters; preserve source expiration dates.
- Save approved applications as `docs/cv-generator/resumes/<short-description-company-job-role>/resume.yaml` and `resume.pdf`, using a safe descriptive slug. Preserve existing application directories unless the user explicitly requests a revision.
- Render the application YAML directly with the same uv-managed RenderCV command, using absolute input/output paths and a separate intermediate folder under `build/`.
- Application YAML is an approved snapshot: later edits to the resolved career input do not automatically update it. Refresh it only within the user's requested scope.

## Validation and handoff

- Parse source and prepared RenderCV YAML before rendering. Validate selected employer IDs, roles, dates, bullet sources/counts, skill categories, education, and certifications against the current source.
- For a general CV, confirm every included company appears exactly once with the intended title and tenure, excluded companies stay absent, and the headline stays omitted unless requested.
- Regenerate affected PDFs after content or design changes. Render every page to images and inspect for clipping, overlap, orphaned headings, broken links, poor spacing, and unreadable text. Text extraction alone does not verify layout.
- Aim for a readable two-page general CV, but do not discard requested content or reduce readability merely to hit a page count. Report the actual page count.
- General CVs and application resumes remain separate artifacts. Never publish or replace website files as a side effect of local document preparation.
- Keep `build/`, `docs/cv-generator/`, Python bytecode, and local environments ignored. Inspect Git status, preserve unrelated changes, and commit or publish only when requested.
- Update this guide and `README.md` when source conventions, commands, design defaults, or output paths change. Do not restore a parallel set of document rules in a script.
- In the handoff, summarize changes, checks actually completed, and unresolved evidence or rendering issues. Link only verified output files and report PDF page counts.
