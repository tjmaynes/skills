---
name: resume-generator
description: Create an evidence-based, job-tailored RenderCV resume for software engineers and adjacent technical roles using career-history YAML. Assess fit and ATS coverage before generating artifacts; stop below 90/100 and require explicit approval before writing a resume.
license: MIT
metadata:
  category: career
  difficulty: advanced
---

# Resume Generator

Create a truthful, tailored resume for a technical job application. This skill uses a career-history YAML file as the sole source of candidate claims and uses RenderCV to generate the final PDF.

## Scope and non-negotiable rules

- Use this skill only for software engineering and adjacent technical roles.
- Default the career-data input to `career.yaml`; accept another path only when the user provides one.
- Use `reference-resume.yaml` in this bundle as the RenderCV schema and layout reference.
- RenderCV is required. Do not write a final application artifact until a local RenderCV command is available.
- Job-description retrieval is read-only. Do not upload career data, job text, or personal details to third-party services.
- A URL is preferred. If it is inaccessible, authentication-gated, incomplete, or unreliable, request a pasted job description. Never assess a job from its title alone.
- Do not invent, strengthen, or imply technologies, metrics, scope, ownership, customer impact, or people-management experience.
- Do not keyword-stuff. A job requirement may appear in the tailored resume only when the career data explicitly supports it.
- Do not create a resume below the fit threshold or before explicit approval.
- Do not overwrite a prior application directory.

## Required inputs

Collect or identify:

1. Career-data YAML path. Default: `career.yaml`.
2. Job-description URL and/or pasted job description.
3. Company and role, if they cannot be confidently extracted from the description.
4. Any missing required profile details only when the career data and selected RenderCV sections require them.

The expected canonical career schema has top-level profile fields (`name`, `email`, `website`, `social_networks`, and `summary`), plus `skills`, `employers`, `work_projects`, `personal_projects`, `education`, and `certifications`.

## Intake and source validation

1. Parse the career YAML before making any recommendation. Report the file and YAML error when parsing fails.
2. Read the job URL when it is accessible. If it cannot provide the full description, request pasted job description text and wait.
3. Extract the target title, seniority, must-have requirements, preferred qualifications, responsibilities, domain context, and measurable outcomes expected by the employer.
4. Check that every selected work project has a resolvable `employer_id`. Do not guess an employer, position, or title when the reference is missing.
5. Resolve a selected project to an employer position by date overlap. When overlapping positions make attribution unclear, show the ambiguity and ask the user rather than collapsing titles.
6. Preserve `personal_projects` as independent records. Include them only when their evidence strengthens the target role.
7. Treat expired certifications accurately: exclude expired certifications by default, or label them as expired when their historical relevance is material.
8. For duplicate project names, cite the project group, employer identifier when present, exact name, and description bullet index. Do not use a name alone as provenance.

## Evidence mapping

Create a requirement-to-evidence table before calculating fit. Every positive row requires a source citation in one of these forms:

- `skills.<category>[<item>]`
- `work_projects[<employer_id>/<project name>].description[<index>]`
- `personal_projects[<project name>].description[<index>]`
- `employers.<employer_id>.positions[<index>]`

Classify each requirement as one of:

- **Direct evidence:** Explicitly named skill, responsibility, or outcome.
- **Demonstrated evidence:** Clearly performed in a cited project description, without broadening the claim.
- **Weak or adjacent evidence:** Related but insufficient for a direct match; it cannot be represented as a match on the resume.
- **No evidence:** Not supported by the career data.

Distinguish the candidate contribution from a team or organization result. Preserve supplied metrics exactly and never derive new numbers.

## Evidence-based fit estimate

Read `references/fit-rubric.md` and present its 0–100 calculation. Call it an **evidence-based fit estimate**, never a prediction or guarantee of an interview.

The rubric weights are:

| Dimension | Weight |
| --- | ---: |
| Requirements match | 40 |
| Relevant impact | 25 |
| Seniority and scope | 20 |
| Evidence strength | 15 |

Rules:

- A missing must-have requirement prevents a 90/100 or higher estimate unless the job description explicitly identifies it as optional.
- Show the score for each dimension, the calculation, matched citations, and the uncertain or missing requirements.
- Keep preferred qualifications distinct from must-haves.

### Below 90/100: stop

If the evidence-based fit estimate is below 90/100, do not propose a selected resume, do not create `resumes/`, and do not write YAML or PDF artifacts. Return:

1. Overall and per-dimension score.
2. Matched evidence and citations.
3. Gaps categorized as missing experience or technology, weakly documented experience, or resume-presentation gaps.
4. Honest next steps: document existing work better, gain the experience, build a learning project, or target a role with stronger evidence alignment.

Do not suggest fabricating experience or disguising a gap with vague terminology.

### At least 90/100: propose, then wait

If the estimate is at least 90/100, show a proposal before writing files:

1. The fit breakdown and citations.
2. A one-paragraph tailored-summary direction based only on cited evidence.
3. Selected employers, positions, projects, and exact description bullets.
4. Tailored skills selected verbatim from career data.
5. Education and certifications selected under the currency rule.
6. The ATS simulation described below.
7. The intended output path.

Ask for explicit approval of the proposed selection and wording. No `resume.yaml`, PDF, or destination directory may be created until the user gives explicit approval.

## ATS simulation

Run a transparent ATS simulation as a coverage report, not as a vendor-specific score or a promise of passing an applicant-tracking system. Use standard section names from the RenderCV reference document and inspect the proposed resume content against extracted job requirements.

For every important job term, report one status:

- **Supported and represented:** Direct evidence appears in the proposed summary, skills, or experience.
- **Supported but not selected:** Career data supports the term, but the current proposed selection omits it; explain whether adding it would improve relevance.
- **Missing evidence:** Career data does not support the term; leave it out of the resume and include it in the gap report when material.
- **Unsafe to add:** The wording would overstate adjacent evidence or introduce an unsupported claim.

Favor readable, evidence-backed language over keyword density. Do not claim an ATS will rank, parse, or select the resume in a particular way.

## Generate the RenderCV artifacts after approval

1. Confirm that RenderCV is installed and runnable locally. Prefer the repository virtual environment:

   ```sh
   .venv/bin/python -m rendercv --version
   ```

2. Derive lowercase, filesystem-safe `company-name` and `role` slugs. Remove unsafe characters; if a safe slug cannot be derived, ask the user for an override.
3. Use exactly this destination shape:

   ```text
   resumes/<company-name>-<role>/<yyyy-mm-dd>/
   ```

   Write `resume.yaml` and `resume.pdf` inside that directory.
4. Before creating the directory, check whether it exists. If it exists, stop and ask for direction. Never overwrite it.
5. Populate a new YAML file using `reference-resume.yaml` as the RenderCV-format guide:
   - map profile data from the career YAML;
   - use the approved summary direction and selected skills;
   - group approved experience by employer and position, preserving date/title accuracy;
   - use only approved project bullets and evidence-backed terms;
   - include personal projects only when approved and relevant;
   - include education and certifications according to the selection rules;
   - preserve the reference document's `sb2nov` theme unless the user requests a different theme.
6. Parse the generated YAML before rendering.
7. Render directly rather than invoking repository-wide build recipes:

   ```sh
   .venv/bin/python -m rendercv render \
     resumes/<company-name>-<role>/<yyyy-mm-dd>/resume.yaml \
     --pdf-path resumes/<company-name>-<role>/<yyyy-mm-dd>/resume.pdf \
     --output-folder <temporary-rendercv-directory>
   ```

8. Confirm the PDF exists and has nonzero size. Report both paths.

## Failure behavior

| Condition | Required response |
| --- | --- |
| Job URL cannot be read | Request pasted job description text. |
| Career YAML is invalid | Identify the file/error and stop. |
| Required profile value is absent | Ask for only the missing value before generation. |
| Fit is below 90/100 | Stop before file creation and provide the categorized gap report. |
| User has not approved | Stop after proposal; do not create output. |
| Destination exists | Stop; never overwrite. |
| RenderCV unavailable | State the missing prerequisite and the required local setup; do not claim success. |
| RenderCV fails | Preserve an approved YAML if already written, show the error, and do not claim the PDF exists. |

## Final handoff

For every completed assessment, state:

- evidence-based fit estimate and rubric breakdown;
- ATS simulation statuses and unresolved gaps;
- selected source citations;
- whether the workflow stopped, awaits approval, or rendered successfully;
- artifact paths only after they exist;
- any remaining formatting or evidence questions.

## Bundle validation

Run the repository-local validation before handing off changes to this skill:

```sh
.venv/bin/python -m unittest discover \
  -s .agents/skills/resume-generator/tests \
  -p 'validate_*.py'
git diff --check
```

The tests render `reference-resume.yaml` with the direct local RenderCV invocation and create only temporary smoke-test artifacts.
