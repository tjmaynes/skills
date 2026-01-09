# Agent Modes for Implementation Planning

Guide for LLMs and agents on how to interact with developers when creating implementation plans.

## Operating Modes

Choose the appropriate mode based on the information provided:

### Mode 1: Full Information Provided
**When:** Developer has clearly described the feature with most details (title, requirements, non-goals, effort, risks)

**Actions:**
- Proceed directly to creating the implementation plan
- Fill in any minor gaps with reasonable assumptions
- Note assumptions in the plan if they're not obvious

**Example trigger phrases:**
- "Add dark mode with this scope..."
- "Here's what we need: [detailed list]"
- "We want to implement X, estimate Medium, @jane will own it"

---

### Mode 2: Partial Information
**When:** Key details are missing (non-goals, effort sizing, risks)

**Actions:**
- Ask clarifying questions using structured format
- Group related questions together
- Limit to 3-5 questions per round
- Wait for answers before proceeding

**Example trigger phrases:**
- "I want to add user authentication"
- "We need to implement email verification"
- "Build a new dashboard"

---

### Mode 3: High-Level Concept Only
**When:** Only the feature idea exists (no requirements or other details)

**Actions:**
- Ask comprehensive discovery questions first
- Help the developer think through requirements and non-goals
- Then proceed to plan creation

**Example trigger phrases:**
- "Add dark mode"
- "Implement payments"
- "Create user profiles"

---

## Clarification Question Templates

### For Requirements
- "What are the 3-5 main capabilities this feature must provide?"
- "How does this feature interact with existing systems/data?"
- "Are there different user roles with different requirements?"

### For Non-Goals
- "What related features should we explicitly NOT build right now?"
- "What requirements seem important but are out of scope for this phase?"
- "Are there any constraints we should acknowledge upfront?"

### For Effort
- "Do you have a rough estimate on complexity? What factors into it?"
- "Are there any constraints that would make this faster or slower than expected?"
- "What activities will take the most time (design, implementation, testing)?"

### For Risks
- "What could go wrong during implementation?"
- "Are there any dependencies on other teams or systems?"
- "Do you see any technical challenges that need mitigation?"

---

## Decision Logic

### When to Ask Questions

**✅ DO ask** if:
- Effort estimate is missing
- Non-goals section would be empty or unclear
- Significant risks exist but weren't mentioned
- Dependencies are ambiguous (external services, team approvals, etc.)

**❌ DON'T ask** if:
- Information is already provided (even if brief)
- The feature is simple and gaps are obvious
- The developer explicitly says "fill in the details"
- Asking would block plan creation unnecessarily

---

## Example Clarification Flows

### Scenario 1: High-Level Only (Mode 3)

**Developer:** "I want to add dark mode toggle"

**Agent Response:**
"I'll help you create an implementation plan for dark mode. Let me ask a few questions first:

1. Who should own this feature?
2. What's your rough estimate: Small (1-2 days), Medium (3-5 days), or Large (6+ days)?
3. What related features should NOT be included? (e.g., customization, OS-level integration?)"

**After answers:** Proceed to create the full plan with all sections

---

### Scenario 2: Partial Information (Mode 2)

**Developer:** "Add email verification. It's Medium effort. Users must verify before accessing features."

**Agent Response:**
"Great! I have effort outlined. A few more questions:

1. Are there any constraints? (e.g., email service, domain restrictions)
2. What edge cases matter? (e.g., spam email address, multiple attempts)
3. Any risks we should plan for? (e.g., email delivery issues)"

**After answers:** Create the full plan

---

### Scenario 3: Full Information (Mode 1)

**Developer:** "Add dark mode toggle. Small effort. Persist to localStorage, works on mobile/desktop, WCAG AA compliant. Out of scope: OS integration, customization beyond light/dark. Risks: FOUC on load, browser support. No new dependencies needed."

**Agent Response:**
"I have all the details. Creating the implementation plan now..." → Proceed directly

---

## Best Practices for Agent Behavior

### Be Conversational
- Ask open-ended questions
- Show you're listening to answers
- Adapt follow-up questions based on responses

### Don't Over-Ask
- Three well-chosen questions > ten thorough questions
- If info seems implied, trust the developer's judgment
- Ask about risks only if they haven't mentioned them

### Provide Context
- When asking, explain why you need the info
- Show how it affects the plan
- Help developers think through implications

### Respect Developer Time
- If they say "just fill it in", do that
- If they provide partial info, don't ask for the remaining 30% of details
- Use professional judgment about trade-offs

---

## Integration with Implementation Plan Creator Skill

This agent behavior guide should be consulted when using the `implementation-plan-creator` skill:

1. **Start**: Developer initiates with feature idea
2. **Assess Mode**: Determine which operating mode applies
3. **Ask or Proceed**: Based on mode, either ask questions or create plan directly
4. **Generate Plan**: Use the main SKILL.md to create the implementation plan
5. **Deliver**: Present completed plan

**Key reference:** See `SKILL.md` for the implementation plan template and structure.
