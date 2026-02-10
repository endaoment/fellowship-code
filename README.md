# Fellowship Code

> **It fellowships your code.** Get it?

An open-source multi-agent AI engineering team for [Cursor](https://cursor.com), built on [Cursor's self-driving codebases research](https://cursor.com/blog/self-driving-codebases). Each agent is a character from Tolkien's Fellowship, with a clear role, personality, and domain expertise -- all working together to take your codebase from idea to production.

You describe the quest. Gandalf assembles the team. The Fellowship gets it done.

---

## What Is This?

Fellowship Code is a **plug-and-play multi-agent system** for AI-assisted software development. It gives you a team of specialized AI agents that can:

- **Architect** a feature across your entire codebase
- **Implement** across multiple repos in parallel
- **Test** with TDD discipline
- **Review** code before humans see it
- **QA** and polish PRs until they're merge-ready
- **Deploy** to production

Each agent has a distinct personality, hard constraints, and graceful degradation -- so they know what to do when things go right *and* when things go wrong.

**Built by [Endaoment](https://endaoment.org)**, the first community foundation built on crypto rails. We use the Fellowship daily to build our platform. Now we're sharing it with the world.

## Quick Start

```bash
# Clone into your project's rules repo (or any config directory)
git clone https://github.com/endaoment/fellowship-code.git fellowship

# Install -- creates symlinks into your claude/ directory
cd fellowship
./setup.sh

# That's it. Open Cursor and try:
# "Ask Gandalf to explore the codebase and describe the architecture."
```

To remove:

```bash
./uninstall.sh
```

## The Fellowship

| Member      | `subagent_type`             | Role                     | Personality                                         |
| ----------- | --------------------------- | ------------------------ | --------------------------------------------------- |
| **Gandalf** | `gandalf-the-architect`     | Orchestrator & Architect | Wise, sees the full map, guides but does not code   |
| **Aragorn** | `aragorn-the-lead-dev`      | Lead Dev                 | Decisive, takes the hardest tasks, leads from front |
| **Legolas** | `legolas-the-frontend-dev`  | Frontend Dev             | Precise, elegant, sharp eye for UI detail           |
| **Gimli**   | `gimli-the-backend-dev`     | Backend Dev              | Sturdy, reliable, builds deep foundations           |
| **Frodo**   | `frodo-the-test-writer`     | Test Writer              | Carries the burden of proof, meticulous TDD         |
| **Samwise** | `samwise-the-qa-dev`        | QA & Polish              | Loyal to quality, nothing ships without proof       |
| **Merry**   | `merry-the-ops-dev`         | Ops & Infrastructure     | Practical, resourceful, keeps things running        |
| **Pippin**  | `pippin-the-specialist-dev` | Domain Specialist        | Curious, creative, works with powerful forces       |
| **Boromir** | `boromir-the-code-reviewer` | Code Reviewer            | Protective, opinionated, catches weaknesses         |
| **Smeagol** | `smeagol-the-pm`            | Project Manager          | Guards every record, nothing escapes tracking       |

> **Pippin is customizable.** Out of the box, Pippin is a domain specialist you can tailor to your project's unique needs -- smart contracts, ML pipelines, mobile development, data engineering, or anything else. See `agents/pippin-the-specialist-dev.md` to customize.

## How It Works

```
You describe the quest
    |
    v
Main Conversation = Gandalf (the orchestrator -- sees the full map)
    |-- reads gandalf-the-architect.md (identity + planning methodology)
    |-- reads fellowship-roster.md (who to send)
    |-- reads planner-methodology.md (how to plan)
    |-- reads team-handoff-protocol.md (how reports come back)
    |
    +-- dispatches Legolas  (subagent_type: "legolas-the-frontend-dev")
    +-- dispatches Gimli    (subagent_type: "gimli-the-backend-dev")
    +-- dispatches Frodo    (subagent_type: "frodo-the-test-writer")
    |
    v
Reads reports --> reassesses the quest --> dispatches next wave
```

1. You invoke a phase command (e.g., `/build-full-stack "Add user authentication"`)
2. The main conversation becomes **Gandalf** -- the orchestrator who sees the full map
3. Gandalf identifies 3-4 high-impact tasks and picks the right members
4. Members are dispatched as subagents, each with their own pre-loaded identity
5. Each member works independently and returns a structured handoff report
6. Gandalf reads the reports, reassesses, and dispatches the next wave
7. Repeat until the quest is complete

## Phase Commands

Phase commands are how you rally the Fellowship for a quest. Each phase focuses on a stage of the software development lifecycle.

| Command               | The Quest                          | Who Rides Out                                 |
| --------------------- | ---------------------------------- | --------------------------------------------- |
| `/spec-and-plan`      | Scout the terrain and draw the map | Gandalf, Smeagol                              |
| `/build-full-stack`   | Build it across the realms         | Aragorn, Legolas, Gimli, Pippin, Merry, Frodo |
| `/qa-and-polish`      | Verify the work holds up           | Samwise, Frodo, Boromir                       |
| `/code-review`        | Guard the gate before merging      | Boromir, Gandalf                              |
| `/deploy-and-release` | Ship to production                 | (your release tooling)                        |

### Try It Out

**Send a single member** on a focused task:

```text
Ask Gandalf to explore the codebase and describe the current
authentication architecture.
```

**Rally the Fellowship** for a larger quest:

```text
/spec-and-plan Add a user notification preferences page where users
can configure email and push notification settings per category.
```

**Chain quests** for a full feature lifecycle:

```text
/spec-and-plan "Add recurring payments..."         → Gandalf scouts, Smeagol tracks
/build-full-stack "Implement. Spec: ..."            → the team builds
/qa-and-polish "PRs: https://..."                   → Samwise verifies, Boromir guards
/deploy-and-release "Release frontend + backend"    → ship it
```

### When to rally vs. send a scout

| Situation                       | Do this                                |
| ------------------------------- | -------------------------------------- |
| 1 repo, < 1 hour of work       | Send one member (e.g., Gimli, Legolas) |
| 2+ repos or 3+ members needed  | Rally with a phase command             |
| Need architecture before coding | Send Gandalf, or `/spec-and-plan`      |
| PRs exist, need QA + cleanup   | `/qa-and-polish`                       |
| Quick single-PR review         | Send Boromir directly                  |

## Customization

The Fellowship is designed to be adapted to your project. Here's how:

### 1. Customize Agent Domain Knowledge

Each agent file has a `## Domain Knowledge` section. Replace it with your project's specifics:

```markdown
## Domain Knowledge

**Repo**: `my-backend` (Django monolith)

- **Framework**: Django 5.0 with DRF
- **Database**: PostgreSQL with Django ORM
- **Queue**: Celery with Redis
- **Auth**: JWT via django-rest-framework-simplejwt

### Commands
\```bash
python manage.py runserver    # Dev server
python manage.py test         # Run tests
ruff check .                  # Lint
\```
```

### 2. Add or Remove Agents

Don't need a domain specialist? Remove `pippin-the-specialist-dev.md`. Need a mobile dev? Create `eowyn-the-mobile-dev.md` following the same pattern. Update the roster in `docs/fellowship-roster.md`.

### 3. Swap Project Management

Smeagol wraps your PM tool. Out of the box, Smeagol is generic. Point it at your project management system (Jira, Linear, Notion, GitHub Issues) by updating the agent file.

### 4. Bring Your Own Tech Stack

The agents are stack-agnostic in the open-source version. Add your specific frameworks, conventions, and commands to each agent's Domain Knowledge section.

See `examples/example-claude-md.md` for a complete integration example.

## Selective Installation

Not every quest needs the full Fellowship. Install only what you need:

```bash
./setup.sh                  # Full Fellowship
./setup.sh --no-docs        # Team without reference docs
./setup.sh --agents-only    # Just the members, no phase commands
./uninstall.sh --docs-only  # Remove docs, keep the team
```

## Design Principles

From the [Cursor research](https://cursor.com/blog/self-driving-codebases) and our own experience:

1. **Anti-fragile** -- if one member fails, the quest continues. Every agent has graceful degradation.
2. **Constraints over instructions** -- tell the team what NOT to do; they know how to do their job.
3. **Intent over checklist** -- describe the destination, not every step of the path.
4. **Dedicated identity** -- each member knows who they are before you send them.
5. **Concrete quantifiers** -- "3-15 issues" not "many issues"; "3-4 members" not "several."
6. **Smart prioritization** -- 3-4 highest-impact tasks per wave (Cursor limit: 4 concurrent).
7. **Accept turbulence** -- members may step on each other's work briefly; Gandalf resolves it.

## Project Structure

```
fellowship-code/
├── README.md                  # You are here
├── setup.sh                   # Install the Fellowship
├── uninstall.sh               # Clean removal
├── LICENSE                    # MIT
├── CONTRIBUTING.md            # How to contribute
│
├── agents/                    # Agent identity files (10)
│   ├── gandalf-the-architect.md
│   ├── aragorn-the-lead-dev.md
│   ├── legolas-the-frontend-dev.md
│   ├── gimli-the-backend-dev.md
│   ├── frodo-the-test-writer.md
│   ├── samwise-the-qa-dev.md
│   ├── merry-the-ops-dev.md
│   ├── pippin-the-specialist-dev.md
│   ├── boromir-the-code-reviewer.md
│   └── smeagol-the-pm.md
│
├── docs/                      # Reference docs for Gandalf
│   ├── fellowship-roster.md
│   ├── planner-methodology.md
│   ├── team-handoff-protocol.md
│   └── phase-artifacts.md
│
├── rules/                     # Team operation rules
│   └── team-operations.md
│
├── skills/                    # Phase command skills
│   ├── spec-and-plan/SKILL.md
│   ├── build-full-stack/SKILL.md
│   ├── qa-and-polish/SKILL.md
│   ├── code-review/SKILL.md
│   └── deploy-and-release/SKILL.md
│
└── examples/                  # Integration examples
    └── example-claude-md.md
```

## Requirements

- [Cursor IDE](https://cursor.com) with agent/subagent support
- A `claude/` or `.claude/` directory in your project for agent configuration
- That's it. No dependencies, no build step, no runtime.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). We welcome new agents, improved phase commands, and adaptations for different tech stacks.

## Credits

Built by the engineering team at [Endaoment](https://endaoment.org), who use the Fellowship daily to build a community foundation on crypto rails.

Inspired by:
- [Cursor's self-driving codebases](https://cursor.com/blog/self-driving-codebases) research
- J.R.R. Tolkien, obviously
- Every engineering team that wishes they had 10 tireless colleagues

## License

MIT -- see [LICENSE](LICENSE).

---

*One does not simply ship code without the Fellowship.*
