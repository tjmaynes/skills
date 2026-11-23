# CV Generator agent skill

CV Generator helps an agent create a general CV or a resume tailored to a job description using career evidence in YAML. It prepares RenderCV input, renders a PDF locally, and checks the result. [SKILL.md](SKILL.md) contains the authoritative workflow and document rules.

This is an agent skill, not a standalone command-line generator. The agent selects and edits content from the evidence before rendering; running RenderCV alone does not prepare or update that content.

## Use

Make this directory available to your agent as a project skill, then ask it to create a document. For example:

- “Use the cv-generator skill to generate my general CV.”
- “Use the cv-generator skill to tailor my resume to this job posting: `<URL>`.”
- “Use the cv-generator skill with `path/to/career.yaml` to create my CV.”

For a tailored resume, provide a complete job description or an accessible link. If the link cannot be read, the agent will request the text. It will assess fit against the evidence and should not invent qualifications. If an available resume-generation skill requires an approval step, its workflow also applies.

## Career evidence

The skill expects a career YAML file with the fields used in [SKILL.md](SKILL.md), including profile information, employers and positions, skills, education, and certifications. See the fictional [example career file](examples/career.yaml) for the expected structure. Copy and adapt it to your own career; do not use its fictional claims in your documents.

The agent resolves the input in this order:

1. An explicitly supplied path, relative to the active project root if not absolute.
2. `career.yaml` in the active project root.
3. `references/career.yaml` in the active project root.

If the explicit path is missing or unreadable, the agent stops without falling back. If neither default exists, it stops and asks for an input path.

## Requirements

- `uv`, with access to Python 3.13 and `rendercv[full]==2.8`.
- `PyYAML==6.0.3` when Python is used to parse or validate YAML.
- A local PDF inspection tool that can report page count and render pages to images, such as Poppler's `pdfinfo` and `pdftoppm`.
- A web-reading tool for job posting URLs, or the complete job description supplied as text.

Reuse an existing suitable environment where possible. The skill does not require changes to a global Python installation.

## Outputs

Paths below are relative to the active project root unless noted otherwise:

- `docs/cv-generator/cv.pdf`: general CV.
- `docs/cv-generator/resumes/<short-description-company-job-role>/resume.yaml` and `resume.pdf`: tailored application snapshot.
- `build/` inside the skill directory: disposable RenderCV input and intermediates.

The agent validates the source and output, then inspects every rendered page. Existing application snapshots are not automatically updated when the source changes. The agent preserves existing application directories unless asked to revise them.

Career evidence and application materials can contain private information. Keep them local and configure the host project's ignore rules for generated documents, application snapshots, and build artifacts. This repository ignores its generated output locations, but not arbitrary career source files. The skill does not publish documents or contact employers without explicit authorization.

## Evaluations

[evals/evals.json](evals/evals.json) contains manual behavioral scenarios for CV creation, job-linked resumes, and input resolution. Run them in an isolated project and inspect the results against the listed criteria. The job-link scenario requires a suitable posting URL; the file is not an automated test runner.
