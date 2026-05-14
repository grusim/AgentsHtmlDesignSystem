# SPEC

## §G goal

ship comms skill `agents-html-comms` — picks artifact type for given comms task, hands off render to installed `agents-html-design` skill. produces vibrant html artifacts for team meetings, spec clarification, requirement mocks, api/diagram sketches.

## §C constraints

- C1 skill = pure workflow. zero render code. design system = visual authority.
- C2 source of truth = this repo at `skills/agents-html-comms/`. Distribution: users clone repo → run `deploy.sh` which **copies** (! symlinks) into `~/.claude/skills/agents-html-comms/`. Clean-copy decouples runtime from in-progress edits + matches downstream consumer install pattern. Redeploy on each change.
- C3 hard dep: `agents-html-design` skill must be loadable. if missing → skill aborts w/ install hint.
- C4 output html = self-contained per design `AGENTS.md` (TOC, back-links, prev/next, inline tokens).
- C5 voice = caveman default for clear/undisputed specs (max compression). dial down or off for intricate concepts needing explanation. unclear → ask user. visual rules still hard: no emoji, no blue-purple gradients, 1.5px `--g300` borders.
- C6 no impl of design system inside this repo. zero copy of tokens/fonts.

## §I interfaces

- I.skill `skills/agents-html-comms/SKILL.md` in this repo — frontmatter `name: agents-html-comms`, `user-invocable: true`, description triggers on team comms phrasings. Consumer installs via clone + symlink/copy into `~/.claude/skills/` or `<proj>/.claude/skills/`.
- I.dep `agents-html-design` skill (installed at `~/.claude/skills/agents-html-design/`).
- I.artifacts emitted (html, self-contained):
  - I.memo status/launch/decision memo → doc kit
  - I.deck 4–10 slide deck → slides kit
  - I.diagram api map, sequence, dep graph → schematic svg + doc kit container
  - I.mock ui sketch / wireframe → doc kit + ornament/blob assets
  - I.scribble loose idea board / brainstorm dump → doc kit cards, hand-feel via stroke svg thumbs
  - I.spec requirement / acceptance criteria explainer → doc kit memo blocks
- I.usecases use-case shortcuts (route to I.artifacts primitives):
  - I.uc.onepager **feature one-pager** (early concept, leadership skim) → memo
  - I.uc.prototype **click-through prototype** (pre-impl, design review) → mock w/ interactive states
  - I.uc.archdiagram **architecture diagram** (cross-team eng review) → diagram
  - I.uc.specdeck **spec deck** (team kickoff) → deck (title → context → 3-up options → decision → next)
  - I.uc.midflight **mid-flight status** (in-progress weekly) → memo (working-memo body)
  - I.uc.prelaunch **pre-launch explainer** (days before ship) → memo + embedded mock/screenshots
- I.cli no cli. invocation = natural language in claude code session.

## §V invariants

- V1 SKILL.md frontmatter ! contain `name`, `description`, `user-invocable: true`. miss any → skill ! discoverable.
- V2 skill body ! reference `agents-html-design` by name + describe handoff. zero verbatim copy of design tokens, fonts, css, components.
- V3 every emitted artifact = single self-contained `.html`. no external `<link>` to repo css/js.
- V4 every emitted artifact pastes `colors_and_type.css` `:root` block inline (per design SKILL.md rule).
- V5 multi-file output → TOC + back-links + prev/next + ghost-state for first prev / last next. source rule = repo-root `AGENTS.md` (the project manifesto), mirrored verbatim into comms `SKILL.md § OUTPUT STRUCTURE RULES` so the installed skill is self-contained and consumers don't need access to the repo root.
- V6 artifact picker MUST classify task into one of {memo, deck, diagram, mock, scribble, spec}. unknown → ask user, ! guess.
- V7 ! emoji. ! blue-purple gradient. ! glass blur. ! 1px borders. ! whole-sentence italic.
- V11 body copy voice = caveman when spec is clear/undisputed. switch to plain editorial when concept needs explanation. ! mix mid-paragraph. choose per-section.
- V12 invoke `agents-html-design` skill FIRST on every artifact request — load brand context before any compose step. ! just a dep check, ! compositional. missing → V9 abort path.
- V13 scoping interview: ask up to 3 Qs before composing — audience, stage, format. skip Qs already answered in user prompt. ! interrogate beyond 3.
- V14 catalog has 2 layers: primitives (I.artifacts) + use-case shortcuts (I.usecases). shortcut MUST route to exactly one primitive. user phrasing matched against shortcuts first, primitives second.
- V15 every artifact ships theme picker (light / auto / dark). picker source = `agents-html-design`'s `theme.js`, inlined verbatim into the HTML's `<head>` BEFORE the `<style>` block. picker UI = segmented control w/ `[data-theme-toggle]` host + 3 `[data-theme-set]` sub-buttons. dark palette MUST live under both `@media (prefers-color-scheme: dark) :root:not([data-theme="light"])` AND `[data-theme="dark"]` so manual override beats OS preference.
- V16 source of truth for design system = upstream zip from claude.ai/design. ! modify `~/.claude/skills/agents-html-design/` locally. fixes that recur across artifacts → fold into comms skill (workflow layer), not into design system.
- V8 ! draw new svg unless trivial. reuse `assets/` from design skill.
- V9 if `agents-html-design` skill missing at invocation → emit install hint (`INSTALL.md` § Option B) + abort.
- V10 capabilities catalog (artifacts × use-cases) lives in skill body. user-visible. updated when new artifact type added.

## §T tasks

| id | st | task | cites |
|----|----|------|-------|
| T1 | x | scaffold `skills/agents-html-comms/` in repo + SKILL.md w/ valid frontmatter | V1,I.skill |
| T2 | x | author capabilities catalog: table of {artifact × use-case × design-kit-source} | V10,I.artifacts |
| T3 | x | author artifact-picker decision tree (task phrasing → artifact type) | V6 |
| T4 | x | author per-artifact playbook: memo, deck, diagram, mock, scribble, spec — each cites design source file | V2,I.artifacts |
| T5 | x | author dep-check preamble: detect `agents-html-design`, abort w/ install hint if absent | V9,C3 |
| T6 | x | author voice + rules section: visual hard rules (V7) + caveman/editorial switching policy (V11) | V7,V11,C5 |
| T7 | x | author multi-file output rules: TOC + back-links + prev/next when >1 html | V5,C4 |
| T8 | x | seed 3 example invocations: "stand-up memo", "api dep diagram", "feature mock for review" | I.artifacts |
| T9 | x | author install section: clone repo → symlink/copy `skills/agents-html-comms` into `~/.claude/skills/` (or project `.claude/skills/`), verify via session start | I.skill |
| T10 | x | verify: open new claude session, ask "what skills?", confirm `agents-html-comms` listed alongside `agents-html-design` | V1 |
| T11 | x | author scoping-interview section: 3 Qs (audience/stage/format), skip-if-answered logic | V13 |
| T12 | x | author use-case shortcut table mapping I.usecases → I.artifacts primitives | V14,I.usecases |
| T13 | x | strengthen DEP CHECK to composition-first: "invoke agents-html-design first" wording | V12 |
| T14 | x | add `skills/agents-html-comms/README.md` (when/why/who framing) + `examples/` dir placeholder | I.skill |
| T15 | x | add theme-picker requirement to comms SKILL.md: inline `theme.js` verbatim + segmented picker snippet + dual-selector dark CSS pattern | V15 |
| T16 | x | document upstream-zip-only policy for design system in comms README + SKILL.md (no local edits to `~/.claude/skills/agents-html-design/`) | V16 |

## §B bugs

| id | date | cause | fix |
|----|------|-------|-----|
| B1 | 2026-05-14 | design system ships no syntax-highlight token vars. comms artifacts hand-rolled colors against `var(--slate)` bg, which flips between themes → code unreadable in dark mode. | RESOLVED 2026-05-14: claude.ai/design re-export ships `--tns-*` palette + `.ds-code-block` pattern + token classes (`.c .k .n .s .f .o .p .y`), theme-independent. comms SKILL.md `CODE BLOCKS` section updated to canonical pattern. example artifacts 02, 03 migrated. interim hand-rolled `.kw/.str/.com/.fn/.num` classes removed. |
