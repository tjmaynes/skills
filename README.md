# AI Agent Skills

A curated collection of structured skills that guide Claude through complex development workflows. Each skill provides detailed guidance, decision logic, and best practices for specific tasks.

**What are skills?** Skills are comprehensive markdown documents that combine workflow guidance, verification checklists, examples, and agent behavior guidelines to help Claude (or any AI) consistently execute high-quality development tasks.

## Quick Start

### Installation

1. **Install dependencies:**
   ```bash
   just install
   ```
   This installs `stow`, `claude-code`, and `codex` via Homebrew.

2. **Deploy skills:**
   ```bash
   just sync
   ```
   This symlinks all skills to `~/.claude/skills` and `~/.codex/skills`, making them available to Claude Code and Codex.

3. **Verify installation:**
   ```bash
   just status
   ```
   Shows which skills are currently deployed.

## Available Skills

### 1. Implementation Plan Creator
**Use this when:** Starting development on a new feature or user-facing functionality.

Create detailed feature implementation plans before coding begins. The skill guides you through:

- **Phase 1:** Analyze and gather requirements, non-goals, risks, and implementation complexity
- **Phase 2:** Generate a structured markdown implementation plan file
- **Phase 3:** Validate completeness and clarity
- **Phase 4:** Verify best practices (specificity, actionability, proper scoping)

**Output:** Markdown file at `plans/YYYY-MM-DD-feature-name.md`

**Documentation:** See `skills/implementation-plan-creator/SKILL.md`

**Example:**
```bash
# Reference the skill when starting a feature
/implementation-plan-creator

# Or use the helper script to create a plan
cd your-project
./scripts/create-plan.sh "Add dark mode toggle"
```

## How to Use Skills

### With Claude Code CLI

Skills are referenced using the `/skill-name` syntax:

```bash
/implementation-plan-creator
```

This loads the complete skill guide, which includes:
- When to use the skill
- Multi-phase workflow with decision points
- Verification checklists at each phase
- Agent behavior guidelines (how Claude should interact)
- Examples and best practices
- Reference materials

### Skill Structure

Each skill file contains:

1. **YAML Frontmatter** - Metadata about the skill
2. **Concept Introduction** - Why this skill exists and when to use it
3. **Decision Points** - When to use, when to skip
4. **Multi-Phase Workflow** - Structured steps with verification checklists
5. **Best Practices** - Do's and don'ts
6. **Examples** - Reference implementations (in `references/`)
7. **Agent Guidelines** - How LLMs should behave (in `references/agent-modes.md`)

## Project Structure

```tree
skills/
├── README.md                        # This file
├── Brewfile                         # Homebrew dependencies (stow, claude-code, codex)
├── Justfile                         # Task runner (install, sync, unsync, status)
├── .claude/
│   └── settings.local.json         # Local permissions configuration
├── scripts/
│   ├── sync.sh                     # Deploy skills to ~/.claude/skills and ~/.codex/skills
│   ├── unsync.sh                   # Remove deployed skills
│   └── status.sh                   # Show current deployment status
└── skills/
    └── implementation-plan-creator/
        ├── SKILL.md                # Main skill documentation (15+ KB)
        ├── scripts/
        │   ├── create-plan.sh      # Helper to generate new plan files
        │   └── ensure-plans-dir.sh # Helper to create plans/ directory
        └── references/
            ├── examples.md         # Detailed examples and patterns
            └── agent-modes.md      # Agent operating modes & clarification strategies
```

## Adding New Skills

To add a new skill to this repository:

1. **Create the skill directory:**
   ```bash
   mkdir -p skills/[skill-name]
   ```

2. **Create SKILL.md** with:
   ```yaml
   ---
   name: skill-name
   description: Brief description of what this skill does
   license: MIT
   allowed-tools: Bash(git:*) Read
   metadata:
     generated-at: "2026-01-09T00:00:00Z"
     group: "development"        # or testing, deployment, etc.
     category: "planning"        # subcategory
     difficulty: "intermediate"  # beginner, intermediate, advanced
     step-count: "3"            # number of main phases
   ---

   # [Skill Name]

   ## What You'll Do
   - [Main deliverable 1]
   - [Main deliverable 2]
   - [Main deliverable 3]

   [Continue with Concept Introduction, When to Use, Phases, Best Practices, etc.]
   ```

3. **Create reference materials:**
   - `references/agent-modes.md` - How agents should interact for different user contexts
   - `references/examples.md` - Real-world examples of the skill in action

4. **Add helper scripts** (optional):
   - `scripts/helper-script.sh` - Utility scripts that support the skill

5. **Deploy:**
   ```bash
   just sync
   ```

## Skill Development Best Practices

When creating or updating skills, follow these principles:

### Content Standards

- **Be specific, not vague** - Use concrete language ("Users can...", "The button will..."), not abstract terms
- **Define non-goals explicitly** - Clarify what will NOT be built (at least 3 items)
- **Write testable criteria** - Each success criterion should be measurable/verifiable
- **Document complexity factors** - Identify dependencies, integration points, and challenges
- **Include code patterns** - When relevant, show examples based on the existing codebase
- **Identify every risk with a mitigation** - Risks without solutions are incomplete
- **Keep it focused** - One clear deliverable per skill, use 1-2 pages

### Structure Standards

- **Multi-phase approach** - Break complex tasks into clear phases (Analysis → Composition → Validation)
- **Decision points** - Include YES/NO branching at key moments
- **Verification checklists** - Each phase should have a completion checklist
- **Agent guidelines** - Include `references/agent-modes.md` for LLM behavior strategies
- **Examples** - Provide complete, detailed examples in `references/examples.md`

### No Placeholders

- Remove all "TBD", "[example]", or incomplete sections before deploying
- Every section should have concrete content

## Management Commands

```bash
# Install dependencies (Homebrew)
just install

# Deploy skills to ~/.claude/skills and ~/.codex/skills
just sync

# Remove deployed skills
just unsync

# Show current deployment status
just status
```

## Contributing

To contribute new skills or improvements:

1. Create your skill in the `skills/` directory following the structure above
2. Test locally with `just sync`
3. Verify the skill with Claude Code: `/skill-name`
4. Create a pull request with a clear description of the skill
5. Include documentation in `README.md` under "Available Skills" section

## How Skills Are Deployed

This repository uses **GNU stow** for symlink-based deployment:

```
Repository (local)           →    User Home Directory (symlinked)
skills/
├── implementation-plan-creator  →  ~/.claude/skills/implementation-plan-creator
└── [future-skills]          →  ~/.claude/skills/[future-skills]
```

**Advantages:**
- Updates in the repository automatically reflect in user's skills directory
- Easy to manage multiple skill repositories
- Non-destructive (symlinks, no file copying)
- Can quickly enable/disable skills with `sync`/`unsync`

## License

All skills in this repository are licensed under the MIT License. See individual SKILL.md files for specific license information.

## Resources

- **Claude Code Documentation:** https://claude.com/claude-code
- **Anthropic API Documentation:** https://docs.anthropic.com
- **GitHub Repository:** https://github.com/tjmaynes/skills

## Feedback

Found an issue or want to improve a skill? Please:
- Report issues at: https://github.com/tjmaynes/skills/issues
- Suggest improvements through pull requests
- Check existing issues before creating new ones
