# Planner Methodology

Detailed planning methodology for Gandalf's orchestrator mode. Referenced from `agents/gandalf-the-architect.md`.

---

## The Cycle: Plan → Delegate → Converge → Reassess

### 1. Plan (start of each cycle)

- Read current state: scratchpad, repo status, issues, CI results
- Identify 3-4 highest-impact tasks that move toward the goal
- Select the right Fellowship member for each task (see worker deployment in `gandalf-the-architect.md`)
- Decide per-task how much context the worker needs:
  - **Narrow scope**: worker gets only their mission + task-specific files
  - **Broad scope**: worker also reads CLAUDE.md for full repo context

### 2. Delegate

- Spawn workers via Task tool using their dedicated `subagent_type` (e.g., `gimli-the-backend-dev`)
- Each worker prompt includes:
  - Their specific mission with clear completion criteria
  - Relevant file paths and context (2-5 key files)
  - Working directory and branch name
  - Done criteria (3-5 measurable items)
- Launch independent tasks in parallel (max 4)

### 3. Converge

- Read all handoff reports from completed workers
- Identify: what succeeded, what failed, what was discovered
- Rewrite the scratchpad with current state (never append)
- Update project tracking if status changed (via PM agent)

### 4. Reassess

- Check against the phase's done criteria
- If done: produce the output report and deliver to user
- If not: identify next 3-4 highest-impact tasks, return to step 1

---

## Scratchpad Management

Maintain `{feature}-scratchpad.md` in the working directory:

```markdown
# Scratchpad: {Feature Name}

## Cycle: {N} | Phase: {spec|build|qa|review|deploy} | Status: {in-progress|blocked|done}

### Completed

- [Artifacts created, with references]

### In Progress

- [Active worker tasks]

### Next

- [Planned for next cycle]

### Blockers

- [Preventing progress]

### Decisions

- [Architecture choices, tradeoffs]
```

Rules:

- Rewrite every cycle — never append
- Max 100 lines — if longer, summarize
- Delete when the phase completes

---

## Dependency Planning

When planning batches, consider common dependency patterns:

- Backend API changes often must land before frontend can consume them
- Specialized domain changes may need deployment before backend integration
- Tests can often run in parallel with implementation
- Ops changes (new env vars, cloud functions) can parallelize with app code

---

## Batch Sizing

- Default: 3-4 workers per cycle (Cursor max: 4 concurrent subagents)
- Worker scope: 1 repo per worker per task
- Cross-repo work requires separate workers coordinated by Gandalf
- For simple phases (deploy, single-repo fix): 1-2 workers is fine
