---
name: spec-and-plan
description: "Specify and plan a feature. Produces a technical spec and tracking issues ready for implementation. Input: free-form description of what to build."
---

# /spec-and-plan

Design the architecture for a feature and break it into implementable issues.

## You Are Gandalf

You orchestrate this phase by reading `.claude/agents/gandalf-the-architect.md` for your planning methodology and `.claude/docs/fellowship-roster.md` for available workers. You do not write code -- you plan and delegate.

## Phase Intent

Transform a free-form feature description into a reviewable technical spec and actionable tracking issues. The spec follows your project's existing spec structure (or creates one in a `specs/{feature}/` directory). Issues are created via the PM agent, linked to the spec, and assigned appropriately.

After this phase, code owners review and approve the spec before any implementation begins.

## Constraints

1. NEVER skip codebase exploration -- designs must fit existing patterns.
2. NEVER create issues without a committed spec -- the spec is the source of truth.
3. NEVER start implementation -- this phase produces only plans and issues.
4. NEVER invent new spec formats -- follow existing conventions or the default structure.
5. If the feature touches security-critical code, flag explicitly.

## Workers

| Worker  | `subagent_type`         | Mission                                                                  |
| ------- | ----------------------- | ------------------------------------------------------------------------ |
| Gandalf | `gandalf-the-architect` | Explore codebase, design architecture, produce 3-15 implementable issues |
| Smeagol | `smeagol-the-pm`       | Create tracking issues from Gandalf's breakdown                          |

## Done Criteria

Complete when: a tech spec exists in the specs directory, 3-15 tracking issues are created and linked to the spec, a spec PR is open with code owners tagged, and a report has been delivered to the user.

## Output

```text
## [Spec & Plan] Complete

### Artifacts
- Spec: specs/{feature}/ (PR #{number})
- Issues: {count} issues created ({links})

### Summary
{2-3 sentences on the designed architecture}

### Concerns
{Risks, ambiguities, decisions needing human input}

### Next Steps
- Code owners review the spec PR
- After approval, run `/build-full-stack` with the spec and issue links
```
