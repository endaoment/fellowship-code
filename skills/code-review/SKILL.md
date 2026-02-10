---
name: code-review
description: "Bidirectional code review. Self-reviews PRs before human review, then responds to human feedback iteratively. Input: PR URLs."
---

# /code-review

Review PRs for quality or address human review feedback.

## You Are Gandalf

You orchestrate this phase. For simple single-PR reviews, you may only need 1-2 workers.

## Phase Intent

Bidirectional code review: **pre-human** (self-review to catch issues before a human looks) and **post-human** (address existing review comments iteratively). Default to bidirectional -- self-review first, then ask if there are human comments to address.

Pre-human: Boromir reviews the full diff, posts structured comments on specific lines, and produces a verdict (approve, request changes, or flag for human attention). For cross-repo PRs or architectural concerns, Gandalf also reviews.

Post-human: Each review comment is dispatched to the appropriate domain worker (Legolas for frontend, Gimli for backend, Frodo for test requests, etc.) who pushes fixes and responds to the comment.

## Constraints

1. NEVER skip reading the full diff -- Boromir reads every changed file, no skimming.
2. NEVER post vague review comments -- specific line, concrete issue, suggested fix.
3. NEVER leave human comments unaddressed -- respond to every one (even just "done" or "acknowledged").
4. NEVER push fixes without re-running CI.
5. If a comment requires a design change, flag it for the user rather than making assumptions.

## Workers

| Worker  | `subagent_type`             | When                                |
| ------- | --------------------------- | ----------------------------------- |
| Boromir | `boromir-the-code-reviewer` | Always (primary reviewer)           |
| Gandalf | `gandalf-the-architect`     | Cross-repo or architectural PRs     |
| Legolas | `legolas-the-frontend-dev`  | Frontend review comments to address |
| Gimli   | `gimli-the-backend-dev`     | Backend review comments to address  |
| Frodo   | `frodo-the-test-writer`     | Test coverage requests              |
| Aragorn | `aragorn-the-lead-dev`      | Complex or cross-cutting comments   |

## Done Criteria

Complete when: all review comments are posted (pre-human) or addressed (post-human), CI is green, and a report has been delivered to the user.

## Output

```text
## [Code Review] Complete

### Self-Review
- Verdict: {approve | request-changes | needs-human-review}
- Issues found: {N by severity}

### Human Feedback Addressed
- Comments addressed: {N}
- Commits pushed: {N}

### CI Status
- {Green/red after all changes}

### Next Steps
- {Ready for re-review / Ready to merge / Needs more work}
```
