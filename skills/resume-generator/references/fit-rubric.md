# Evidence-Based Fit Rubric

Use this rubric for software engineering and adjacent technical roles. It is a transparent evidence-based fit estimate, not a prediction of whether the candidate will receive an interview. Every awarded point must cite evidence in the supplied career-data YAML; do not award credit for plausible but unstated experience.

## Scorecard

| Dimension | Weight | Award credit only when career evidence shows |
| --- | ---: | --- |
| Requirements match | 40 | An explicit required or preferred skill, responsibility, domain, or delivery practice. |
| Relevant impact | 25 | Directly relevant outcomes, scale, metrics, customer value, business value, or delivery results. |
| Seniority and scope | 20 | The ownership and influence expected for the target role, such as technical leadership, architecture, enablement, or people management. |
| Evidence strength | 15 | Specific, recent, complete, and explicitly documented evidence rather than inference. |
| **Total** | **100** | Sum the four dimensions; do not add bonus points. |

The static scorecard labels intentionally include the machine-checkable form:

```text
Requirements match | 40
Relevant impact | 25
Seniority and scope | 20
Evidence strength | 15
```

### Scoring method

1. Extract the job's must-have requirements, preferred qualifications, responsibilities, target seniority, and domain signals from its text. A URL alone is not evidence; request pasted text if the page cannot be read.
2. For each job requirement, locate explicit career evidence. A top-level skill alone supports a term only when it is actually named there; a project bullet supports only the work it explicitly states.
3. Award partial credit only for directly adjacent, truthfully describable evidence. Do not claim an unsupported technology equivalence or turn a related project into a must-have match.
4. Score the four dimensions independently and list both earned and withheld points. Show the sum as `fit estimate: N/100`.

### Evidence-citation format

Use one of these source references for every positive claim:

```text
skills.<category>[<item>]
work_projects.<project_id>.description[<bullet>]
personal_projects.<project_id>.description[<bullet>]
employers.<employer_id>.positions[<position>]
education.<education_id>
certifications.<certification_id>
```

If a work project is used, include its resolved employer and relevant position when the dates make the title material. For duplicate project names, cite the collection plus project identifier; never rely on the display name alone.

## The 90-point gate

An estimate below 90/100 is a stop condition. Report the score, its evidence, and gaps, then create no application directory and no `resume.yaml` or PDF.

A missing must-have requirement prohibits a 90/100 or higher estimate unless the job description explicitly identifies that requirement as optional. Do not offset a missing must-have with unrelated accomplishments, years of experience, or keyword matches. If wording makes a requirement ambiguous, treat it as unverified and ask the user rather than assuming it is optional.

At 90/100 or above, show the proposed summary direction, selected skills, employers/projects, source bullets, and ATS simulation. Wait for the user's explicit approval before creating any output directory or resume artifact.

## Below-threshold gap report

Use all applicable categories and distinguish them clearly:

| Category | Meaning | Appropriate recommendation |
| --- | --- | --- |
| Missing experience or technology | The career data contains no direct evidence for a required qualification. | Identify the requirement; recommend learning, a scoped project, or targeting a role where it is not mandatory. |
| Weakly evidenced experience | The data hints at relevance but lacks a specific technology, responsibility, outcome, date, or scope. | Ask the candidate whether they can document the missing evidence in career data; do not add it to a resume until documented. |
| Resume-presentation gap | Supported material exists but is not selected or clearly framed for the role. | Suggest a truthful selection, ordering, or wording adjustment; do not inflate the score or claim the gap is resolved. |

For each gap, state the requirement, its priority (must-have or preferred), the evidence status, why it affected the score, and the next practical action.

## ATS evidence simulation

This is a transparent coverage check, not vendor-specific ATS emulation. Build it from requirements extracted from the job description and classify each term once:

| Status | Meaning | Resume action |
| --- | --- | --- |
| Supported and represented | Explicit career evidence is selected for the tailored resume. | Keep the clear, natural term with its evidence. |
| Supported but not selected | Explicit evidence exists but is not in the proposed selection. | Explain why it was omitted or add it only if relevant and readable. |
| Missing evidence | No explicit career-data evidence supports the term. | Treat it as a gap; do not add it. |
| Unsafe to add | A term is tempting because of an adjacent technology, but the career data does not substantiate the exact claim. | Exclude it and explain the distinction. |

Never use keyword stuffing. Include terms only where they accurately describe selected evidence in ordinary resume language. Do not repeat terms solely to increase term coverage, and do not substitute unsupported equivalence claims for missing requirements.

## Report template

```text
Evidence-based fit estimate (not a prediction): <total>/100

Requirements match: <earned>/40
- <job requirement> — <supported | partial | missing> — <source citation or gap>

Relevant impact: <earned>/25
- <job need> — <source citation and outcome>

Seniority and scope: <earned>/20
- <target scope> — <source citation and match/limitation>

Evidence strength: <earned>/15
- <recency/specificity/completeness assessment>

ATS evidence simulation
- Supported and represented: <terms and citations>
- Supported but not selected: <terms and citations>
- Missing evidence: <terms>
- Unsafe to add: <terms and reason>

Decision: <stop below 90 with gaps | show proposal and wait for approval>
```
