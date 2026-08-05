---
name: resume-improver
description: Improve resume or career-history YAML by interviewing the user about business impact, technical impact, staff-level engineering leverage, leadership, and scope. Use this skill whenever the user asks to review a resume, CV, career YAML file, project descriptions, work history, or professional summary—even if they do not explicitly ask for a skill or YAML edit.
license: MIT
metadata:
  category: career
  difficulty: intermediate
---

# Resume Improver

Use this skill to turn vague career-history project descriptions into concise, evidence-based descriptions suitable for a staff-level engineering resume.

## Operating principles

- Interview the user rather than guessing. Never invent metrics, outcomes, technologies, ownership, scope, or stakeholder impact.
- Work on one project at a time, in file order unless the user selects a project.
- Ask only the highest-value questions first. Use sharper follow-ups when answers are vague.
- Distinguish the user's contribution from the team's contribution.
- Look for staff-level signals: architectural judgment, cross-team influence, organizational leverage, reusable patterns, strategy, mentoring, operating without direct authority, and durable improvements after the user's direct involvement.
- Preserve the user's voice and factual meaning; improve specificity and evidence, not inflate seniority.
- Do not modify the source file until the user approves the proposed description.

## Inputs and schema

Accept an attached or local YAML file such as `career.yaml`, `work-history.yaml`, `cv.yaml`, or `resume.yaml`. Inspect the file before asking questions.

Support project records with fields such as:

- `name`
- `employer`
- `start_date`
- `end_date`
- `role`
- `role_details`
- `description`
- `skills`
- `team_members`

Treat `description` as a YAML list of strings. Preserve unrelated fields exactly. Preserve `null` values unless the user explicitly asks for a schema change.

## Interview workflow

### 1. Establish the review scope

Identify the file, project order, and intended audience. Default to a staff-level engineering resume. Ask whether to begin with the first project or a named project only when the user has not already indicated a starting point.

### 2. Interview one project

Ask questions conversationally, grouped only when useful:

#### Context and strategy

- What problem or opportunity led to this project?
- Why did the project matter to the business?
- What strategic, organizational, or technical constraints shaped the work?

#### Business impact

- What changed because of the work?
- Did it affect revenue, conversion, retention, cost, productivity, delivery speed, customer experience, risk, or compliance?
- Are there measurable before-and-after results?
- If there are no metrics, what concrete evidence demonstrates the outcome?

#### Technical impact

- What did the user personally design, build, modernize, automate, or improve?
- What architectural decisions did the user make or influence?
- What technical risks, complexity, scale, reliability, performance, security, or operational concerns did the work address?
- Did the work make future changes faster, safer, cheaper, or easier to operate?

#### Organizational leverage

- How did the work influence multiple teams, products, systems, or engineering practices?
- Did the user establish reusable patterns, platforms, standards, tooling, or ways of working?
- Did the work enable other engineers or teams to move faster or make better decisions?
- What improvements persisted after the user's direct involvement ended?

#### Leadership and collaboration

- What decisions did the user lead or influence?
- How did the user align engineers, product managers, designers, business partners, or clients?
- Did the user mentor others, reduce silos, resolve ambiguity, or improve team execution?
- Where did the user operate without direct authority?

#### Scope and ownership

- What was the user's specific contribution versus the team's contribution?
- How large was the team, system, rollout, or affected organization?
- What was difficult, ambiguous, or high-stakes about the work?

Do not ask the removed question about who the users, customers, teams, or stakeholders were unless the user brings that context up voluntarily or it is necessary to understand impact.

### 3. Synthesize evidence

Once enough evidence is available, summarize it under:

- Business impact
- Technical impact
- Organizational leverage
- Leadership and collaboration
- Scope and scale

Call out unsupported claims or evidence gaps explicitly.

### 4. Draft candidate descriptions

Provide two or three candidate descriptions for the project. Each candidate should:

- Start with a strong action verb.
- Clearly distinguish the user's contribution from the team's contribution.
- Show technical depth and architectural judgment.
- Demonstrate leverage beyond a single feature or codebase when applicable.
- Explain the business, customer, or engineering outcome.
- Use metrics only when the user supplied them.
- Avoid buzzwords, inflated claims, and generic responsibility statements.
- Be concise enough for a resume project entry.

Then provide a recommended replacement in the exact YAML shape:

```yaml
description:
  - "First evidence-based accomplishment."
  - "Second evidence-based accomplishment."
```

### 5. Approval and file update

Do not edit the source file automatically. Ask the user to approve the proposed replacement.

After approval:

- Replace only that project's `description`.
- Preserve all other fields and project order exactly.
- Keep descriptions as YAML lists of strings.
- Maintain valid YAML syntax.
- Show the resulting diff or changed project.
- Move to the next project only after confirming the update.

If the user declines, revise the candidates or leave the project unchanged.

## Final review

After all selected projects are reviewed:

- Summarize recurring staff-level strengths supported by the evidence.
- List projects whose evidence remains weak or incomplete.
- Suggest improvements to the overall career summary.
- If asked to rewrite the summary, produce a concise staff-level version that begins with the user's target identity, such as “I'm an engineering manager…” or “I'm a staff-level engineer…”, and substantiate it with recurring themes from the reviewed projects.

## Quality checks

Before delivering any edited YAML:

- Parse it with a YAML parser if available.
- Confirm only approved descriptions changed.
- Check that no unsupported metrics or technologies were introduced.
- Check that each description communicates action, scope, and impact rather than merely listing duties.
