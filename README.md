# agents-html-comms

A Claude Code / agent skill for turning team-communication tasks into vibrant, self-contained HTML artifacts — status memos, decks, API diagrams, feature mocks, brainstorm scribbles, requirement specs.

This repo owns the **workflow** layer. It picks the right artifact type for a given task, runs a short scoping interview, and composes the artifact on top of the visual contract provided by the separate `agents-html-design` skill.

Sibling repos / skills:

- **`agents-html-design`** — the visual contract (palette, typography, components, theme picker, code-block palette). Authored in [claude.ai/design](https://claude.ai/design), distributed as a handoff zip, installed at `~/.claude/skills/agents-html-design/`.
- **`agents-html-comms`** (this repo) — the workflow on top: when to produce a memo vs a deck vs a diagram, how to scope, how to compose, how to ship multi-page walkthroughs.

## Lineage

Derives from Thariq's argument for HTML over Markdown when an artifact deserves to be read:

- Blog post: [Using Claude Code: The Unreasonable Effectiveness of HTML](https://x.com/trq212/status/2052809885763747935)
- Source repo: [html-effectiveness](https://github.com/ThariqS/html-effectiveness)

## Install

```bash
git clone https://github.com/grusim/agents-html-comms ~/src/agents-html-comms
cd ~/src/agents-html-comms
./deploy.sh
```

`deploy.sh` wipes `~/.claude/skills/agents-html-comms/` and copies the current repo state into it. Re-run after every edit during development.

Design system dependency must be installed separately at `~/.claude/skills/agents-html-design/`.

## Layout

- `skills/agents-html-comms/` — the skill itself (this is what gets installed)
- `skills/agents-html-comms/SKILL.md` — action manual followed by the agent
- `skills/agents-html-comms/README.md` — when / why / who per artifact type
- `skills/agents-html-comms/examples/` — worked artifacts
- `AGENTS.md` — project manifesto, mirrored into `SKILL.md`
- `SPEC.md` — caveman-format project spec (`/ck:spec`, `/ck:build`, `/ck:check`)
- `deploy.sh` — installer

## Status

In active development. See `SPEC.md` § T for the live task list.
