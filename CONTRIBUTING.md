# Contributing to Fellowship Code

Thanks for your interest in the Fellowship! Here's how to help.

## Ways to Contribute

### 1. New Agents

Create a new Fellowship member for a role that isn't covered. Follow the existing pattern:

```markdown
---
name: character-the-role
description: "Character the Role. Brief description of what they do."
---

You are {Character}, the {Role} of the Fellowship engineering team. {Personality and approach.}

---

## Hard Constraints
{What they must NEVER and ALWAYS do}

## Intent
{What they're trying to accomplish}

## Domain Knowledge
{What they know about — customize for your stack}

## Graceful Degradation
{What to do when things go wrong, from best to worst}

## Handoff Protocol
{Input they receive, output they return}
```

Key principles:
- **Constraints over instructions** — tell them what NOT to do
- **Intent over checklist** — describe the goal, not every step
- **Graceful degradation** — plan for failure modes
- **Dedicated identity** — they should know who they are

### 2. Stack Adaptations

Adapt agent Domain Knowledge sections for specific tech stacks:
- Django + React? Update Gimli and Legolas.
- Rails + Vue? Same pattern, different specifics.
- Rust + WASM? Customize Pippin.

Submit these as examples in the `examples/` directory.

### 3. New Phase Commands

Add new skills to `skills/`. Each skill follows the pattern:

```markdown
---
name: phase-name
description: "What this phase does."
---

# /phase-name

## You Are Gandalf
## Phase Intent
## Constraints
## Workers
## Done Criteria
## Output
```

### 4. Improved Documentation

Better docs, more examples, clearer explanations — always welcome.

## Guidelines

- Keep agent files focused. Each agent should have a clear, bounded role.
- Preserve the LOTR flavor — it's not just fun, it makes agents memorable and distinct.
- Don't add proprietary or company-specific content — this is a generic framework.
- Test your changes by installing the Fellowship in a real project.

## Process

1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Test by running `./setup.sh` in a project
5. Open a PR with a clear description of what you added/changed

## Code of Conduct

Be excellent to each other. The Fellowship works because everyone has a role and respects the others.
