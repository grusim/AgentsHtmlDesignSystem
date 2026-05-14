# agents-html-comms — when, why, who

Companion to `SKILL.md`. SKILL.md = the action manual the agent follows. This README = the human framing: when this skill earns its keep, why it exists, who benefits.

## Why this skill exists

Most team comms get dumped into Markdown — Slack threads, GitHub comments, Notion pages. Markdown is fine for capture. It's lousy for *clarification* — the moments where a reader has to hold a system, a flow, or a trade-off in their head.

HTML is the better medium for those moments. Inline SVG diagrams, interactive prototypes, vibrant typography, and a real visual hierarchy turn a wall of text into something a teammate actually *reads*.

`agents-html-design` provides the visual contract. This skill provides the workflow on top: which artifact for which situation, how to scope it, how to compose it.

## When to reach for it

- You're about to write a long Slack message explaining a feature → produce a one-pager instead
- A team kickoff needs more than bullet points → produce a spec deck
- An eng review needs to see how services talk → produce an architecture diagram
- A weekly status is drifting into noise → produce a mid-flight status memo
- Brainstorm output is sitting in your head → produce a scribble doc
- A spec keeps being misread → produce a structured spec explainer

## Who benefits

- **Producer** — the agent does the layout work; you focus on the substance
- **Readers** — get a self-contained, single-file artifact that loads anywhere
- **Future you** — artifacts are HTML, not lossy slide screenshots, so they grep, diff, and version-control cleanly

## Artifact catalog at a glance

Six use-case shortcuts, six primitives. See `SKILL.md` for the full mapping and the picker tree.

| Use-case | Stage | Audience | Primitive |
|----------|-------|----------|-----------|
| Feature one-pager | Early concept | Leadership skim | memo |
| Click-through prototype | Pre-implementation | Design review | mock |
| Architecture diagram | Cross-team review | Eng | diagram |
| Spec deck | Team kickoff | Eng team | deck |
| Mid-flight status | In-progress weekly | Team + manager | memo |
| Pre-launch explainer | Days before ship | Broad / external | memo |

This list is a starting point, not a cage. Use-cases not listed → fall through to the primitive picker.

## Composition with `agents-html-design`

Two skills, two repos, two cadences.

- **`agents-html-design`** — visual language. Tokens, type, components, asset library. Changes when the brand changes.
- **`agents-html-comms`** — workflow. When to produce what, how to scope, which patterns to crib. Changes when team comms practice changes.

The comms skill always invokes the design skill first. The design skill never depends on the comms skill — it can be used standalone for any HTML artifact, comms-related or not.

## Examples

`examples/` holds worked artifacts produced by past invocations. Treat as references when picking a pattern, not as templates to copy.

## Contributing

Add a new use-case → extend the table in `SKILL.md` § USE-CASE SHORTCUTS. Add a worked example → drop the HTML file into `examples/` with a one-line README entry.
