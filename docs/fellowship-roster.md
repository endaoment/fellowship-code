# Fellowship Roster

Character-to-role mapping, capabilities, and deployment guide for the Fellowship multi-agent team.

---

## Active Fellowship

| Character | `subagent_type`             | Role                     | Scope       | Personality                                                               |
| --------- | --------------------------- | ------------------------ | ----------- | ------------------------------------------------------------------------- |
| Gandalf   | `gandalf-the-architect`     | Orchestrator & Architect | All (read)  | Wise, assembles the Fellowship, plans the quest, guides but does not code |
| Aragorn   | `aragorn-the-lead-dev`      | Full-Stack Lead          | Any         | Decisive, takes hardest tasks, leads from the front                       |
| Legolas   | `legolas-the-frontend-dev`  | Frontend Dev             | Frontend    | Precise, elegant, sharp-eyed for UI detail                                |
| Gimli     | `gimli-the-backend-dev`     | Backend Dev              | Backend     | Sturdy, reliable, deep foundations                                        |
| Frodo     | `frodo-the-test-writer`     | Test Writer              | Any         | Carries the burden of proof, meticulous                                   |
| Samwise   | `samwise-the-qa-dev`        | QA & Polish              | Any         | Loyal, detail-oriented, nothing overlooked                                |
| Merry     | `merry-the-ops-dev`         | Ops Dev                  | Ops/Infra   | Practical, resourceful, infrastructure logistics                          |
| Pippin    | `pippin-the-specialist-dev` | Domain Specialist        | Specialized | Curious, creative, works with powerful forces                             |
| Boromir   | `boromir-the-code-reviewer` | Code Reviewer            | Any         | Protective, strong opinions, catches weaknesses                           |
| Smeagol   | `smeagol-the-pm`            | Project Manager          | PM tool     | Obsessive, guards every record, nothing escapes                           |

## Future Fellowship Ideas

| Character     | Possible Role        | Notes                             |
| ------------- | -------------------- | --------------------------------- |
| **Eowyn**     | Email/Comms Dev      | Fearless, breaks conventions      |
| **Faramir**   | Release Engineer     | Noble, follows process faithfully |
| **Galadriel** | Product Strategist   | Far-seeing, wise counsel          |
| **Elrond**    | DevOps Architect     | Ancient wisdom, infrastructure    |
| **Theoden**   | Project Coordinator  | Rallies the team, coordinates     |

---

## Phase Deployment Matrix

Which workers participate in which phase:

| Worker          | /spec-and-plan | /build-full-stack | /qa-and-polish | /code-review | /deploy-and-release |
| --------------- | :------------: | :---------------: | :------------: | :----------: | :-----------------: |
| Gandalf         |    Primary     |      Support      |       -        |   Support    |          -          |
| Aragorn         |       -        |      Primary      |       -        |      -       |          -          |
| Legolas         |       -        |     FE tasks      |       -        |      -       |          -          |
| Gimli           |       -        |     BE tasks      |       -        |      -       |          -          |
| Frodo           |       -        |       Tests       |     Tests      |      -       |          -          |
| Samwise         |       -        |         -         |    Primary     |      -       |          -          |
| Merry           |       -        |     Ops tasks     |       -        |      -       |          -          |
| Pippin          |       -        |  Domain tasks     |       -        |      -       |          -          |
| Boromir         |       -        |         -         |    Reviews     |   Primary    |          -          |
| Smeagol         |     Issues     |  Status updates   |       -        |      -       |      QA issues      |

---

## Worker Mission Template

Since each Fellowship member has a dedicated `subagent_type`, their identity and constraints are pre-loaded by the system. Gandalf only needs to provide the mission:

```text
Task(subagent_type="{dedicated-type}", prompt="
## Your Mission
{1-3 paragraphs: specific task with clear completion criteria}

## Context
- Working directory: {repo path}
- Branch: {create feature/XXXX-description from main|develop}
- Key files: {2-5 relevant file paths}
- State: {what's done, what depends on this}

## Done When
- {Measurable criterion 1}
- {Measurable criterion 2}
- {Measurable criterion 3}

## Handoff
Return your report per .claude/docs/team-handoff-protocol.md
")
```

**Key principle**: Do NOT use `subagent_type="generalPurpose"` and inject identity via prompt. Use the dedicated type — the agent already knows who it is.

---

## Deployment Guidelines

- **Default batch size**: 3-4 workers per cycle (Cursor max: 4 concurrent)
- **Worker scope**: 1 repo per worker per task. Cross-repo work requires separate workers.
- **Context decision**: Per-task choice — narrow (mission + files only) or broad (also read CLAUDE.md).
- **Failure handling**: First failure → retry with context. Second failure → reassign to Aragorn. Third → escalate to human.
- **Convergence**: Accept some turbulence between workers. Gandalf resolves conflicts in the convergence step.
