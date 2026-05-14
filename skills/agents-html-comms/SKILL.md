---
name: agents-html-comms
description: Use this skill to turn team-communication tasks into vibrant, self-contained HTML artifacts — status memos, decks, API diagrams, feature mocks, brainstorm scribbles, requirement specs. Picks the right artifact type for the task, then hands off rendering to the `agents-html-design` skill. Use when the user asks to communicate, present, share, explain, sketch, mock, diagram, spec, plan, or scribble for teammates — instead of emitting a wall of markdown.
user-invocable: true
---

# Agents HTML Comms — workflow skill

Pure workflow. Zero render. Visual authority = `agents-html-design` skill.

## STEP 0 — INVOKE DESIGN SKILL FIRST

This skill provides the **workflow**. `agents-html-design` provides the **visual contract**. Compose both.

On every invocation, before any other step:

1. Invoke / read `agents-html-design` SKILL.md so its brand context (palette, type pairing, border / shadow rules, icon rules, voice) is loaded into the active context. Composition first — picker / playbooks below assume those rules are already in scope.
2. Missing skill → STOP. Emit:
   ```
   Missing dependency: agents-html-design skill.
   Install: clone or unzip into ~/.claude/skills/agents-html-design/.
   See: https://github.com/grusim/agents-html-comms (skill README).
   ```
   Do not produce HTML output without it.

## STEP 1 — SCOPING INTERVIEW

Before choosing an artifact, ask up to 3 questions. Skip any already answered in user prompt. ! interrogate beyond 3.

1. **Audience** — eng team / design review / leadership / external?
2. **Stage** — early concept / in-progress / pre-launch / post-launch?
3. **Format hint** — one-pager / deck / interactive prototype / diagram / loose scribble? (user may not know → infer in STEP 2)

Audience drives voice + density. Stage drives tone (exploratory vs committed). Format hint short-circuits the picker if explicit.

## CAPABILITIES CATALOG

What this skill produces × what it's for × where the design source lives:

| artifact | best for | design source |
|----------|----------|---------------|
| **memo** | stand-up note, launch announce, post-mortem, decision record, RFC summary | `ui_kits/doc/index.html` (masthead → sections → cards → memo blocks) |
| **deck** | sprint review, kickoff, exec update, demo slot, lightning talk | `slides/index.html` + `TitleSlide` `ListSlide` `MetricsSlide` `DecisionSlide` `NextWeekSlide` |
| **diagram** | api map, sequence flow, dep graph, service topology, data lineage | doc kit container + schematic inline SVG (style per `ICONOGRAPHY.md`) |
| **mock** | ui sketch, wireframe, before/after, feature preview | doc kit + `assets/ornament.svg` `gradient-blob.svg` `thumb-illustrations/` |
| **scribble** | brainstorm dump, options-on-the-table, loose idea board | doc kit cards arranged loose, stroke-svg thumbs for visual texture |
| **spec** | requirement explainer, acceptance criteria, invariants, gherkin-style flows | doc kit memo blocks + `Controls` component for input/output examples |

Pick one. If task spans two → bias to **memo** as container, embed others as sections.

## USE-CASE SHORTCUTS

If user names a known feature-comms use-case, route directly. Each shortcut → exactly one primitive.

| use-case | when | audience | → primitive | shape |
|----------|------|----------|-------------|-------|
| **feature one-pager** | early concept | leadership skim | memo | TL;DR + problem framing + small sketch |
| **click-through prototype** | pre-impl | design review | mock | doc kit + inline interactive states (anchor links / `<details>`) |
| **architecture diagram** | cross-team review | eng | diagram | SVG flowchart, earth-tone stroke style |
| **spec deck** | team kickoff | eng team | deck | title → context → 3-up options → decision → next |
| **mid-flight status** | in-progress weekly | team + manager | memo | working-memo body (shipped / blocked / next) |
| **pre-launch explainer** | days before ship | broad / external | memo | TL;DR + screenshots / recording embeds + risks |

User phrasing matched against shortcuts first, then the picker below.

## ARTIFACT PICKER — decision tree

Task phrasing → artifact:

- "stand-up", "status", "weekly", "update", "wrote up", "announcement", "post-mortem", "decision", "RFC" → **memo**
- "present", "deck", "slides", "walk through", "review", "kickoff", "demo" → **deck**
- "diagram", "flow", "sequence", "map", "graph", "topology", "how X talks to Y", "data flow" → **diagram**
- "mock", "wireframe", "sketch the UI", "what it looks like", "before/after", "preview the screen" → **mock**
- "brainstorm", "ideas", "options", "scribble", "rough thoughts", "explore" → **scribble**
- "requirement", "acceptance criteria", "spec", "invariants", "must / shall", "behaviour" → **spec**

Phrasing ambiguous → **ASK** user. Do not guess. Cite V6.

## PLAYBOOKS

Each playbook = thin wrapper. Heavy lifting belongs in `agents-html-design`.

### memo

1. Crib `ui_kits/doc/index.html`. Masthead → sections → cards → memo blocks.
2. Sections in order: TL;DR (memo block), Context, What changed, Risks, Next step.
3. Eyebrow lines = UPPERCASE mono. Headlines = serif sentence case. Italic one word per H1.
4. Caveman voice for clear specs. Editorial prose for nuanced bits. Never mix mid-paragraph.

### deck

1. Crib `slides/index.html`. Six slides default — drop / add to fit content.
2. Slide order: Title → List (agenda) → Metrics (numbers / trade-offs) → Decision (recommendation) → NextWeek (actions).
3. Each slide = self-contained `<section>` inside the deck-stage web component.
4. ! more than 6 bullets per slide. ! more than one chart per slide.

### diagram

1. Container = doc kit card.
2. Diagram = inline SVG, stroke-only, 2.5px stroke (Lucide-style), `--g300` color.
3. Reuse `assets/` shapes when they fit. Drawing a fresh SVG only allowed for trivial flow lines.
4. Label nodes in mono. Label edges in serif italic.

### mock

1. Crib doc kit. Wrap mock in a card with mono eyebrow `MOCK — NOT FINAL`.
2. Use `assets/ornament.svg` as section divider. `gradient-blob.svg` for hero areas only.
3. Annotate hot spots with numbered mono callouts.

### scribble

1. Loose grid of doc kit cards. Order doesn't matter — make that visible (rotate offset minimal, ≤ 1deg).
2. Each card = one idea. Use `thumb-illustrations/` as visual anchor per card.
3. Top of doc = mono eyebrow `SCRIBBLE — WORKING THINKING`. Reader knows it's not committed.

### spec

1. Crib doc kit memo blocks for invariants. One block = one invariant. ID column = mono.
2. Acceptance criteria → `Controls` component pattern (input → output).
3. Caveman voice default — specs read better dense.

## THEME PICKER — required on every artifact

Every artifact MUST ship a working light / auto / dark picker. Source of truth is the design system's `theme.js`. To stay self-contained (V3), inline its body verbatim into the artifact's `<head>` BEFORE the `<style>` block (so first-paint applies stored preference). Do not rewrite the script — copy it.

**Markup — segmented control:**

```html
<div class="theme-picker" role="group" aria-label="Theme"
     data-theme-toggle data-theme-current="auto">
  <button type="button" data-theme-set="light">Light</button>
  <button type="button" data-theme-set="auto">Auto</button>
  <button type="button" data-theme-set="dark">Dark</button>
</div>
```

`theme.js` auto-wires the click handler and keeps `[data-theme-current]` in sync.

**CSS — dual-selector dark palette (manual override must beat OS):**

```css
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) { /* dark tokens here */ }
}
[data-theme="dark"] { /* same dark tokens here */ }
```

Both selectors hold the same dark palette. The explicit `[data-theme="dark"]` rule comes last so a manual choice wins over the OS preference. Light is the `:root` default.

Placement: top-right of the page on desktop, full-width above masthead on mobile (`@media (max-width: 720px)`).

See `examples/vue3-pwa-dotnet-architecture.html` for the worked pattern.

## CODE BLOCKS — Tokyo Night Storm

Code surfaces always read as terminal. The Tokyo Night Storm (TNS) palette is theme-independent — it sits on top of either a light or a dark page background unchanged.

Use `agents-html-design`'s canonical `.ds-code-block` pattern. Self-contained artifacts must paste the palette inline:

```css
pre.ds-code-block {
  --tns-bg:      #24283b;
  --tns-fg:      #c0caf5;
  --tns-comment: #7e9b4f;
  --tns-red:     #f7768e;
  --tns-orange:  #ff9e64;
  --tns-yellow:  #e0af68;
  --tns-green:   #9ece6a;
  --tns-cyan:    #7dcfff;
  --tns-blue:    #7aa2f7;
  --tns-purple:  #bb9af7;

  margin: 0;
  padding: 16px 18px;
  background: var(--tns-bg);
  color: var(--tns-fg);
  font-family: var(--mono);
  font-size: 13px;
  line-height: 1.6;
  border-radius: var(--r-sm);
  overflow-x: auto;
}
.ds-code-block .c { color: var(--tns-comment); font-style: italic; }
.ds-code-block .k { color: var(--tns-purple); }
.ds-code-block .n { color: var(--tns-orange); }
.ds-code-block .s { color: var(--tns-green); }
.ds-code-block .f { color: var(--tns-blue); }
.ds-code-block .o { color: var(--tns-cyan); }
.ds-code-block .p { color: var(--tns-red); }
.ds-code-block .y { color: var(--tns-yellow); }
```

**Token classes** (canonical, from `agents-html-design`):

| class | semantic |
|-------|----------|
| `.c` | comment (italic)  |
| `.k` | keyword           |
| `.n` | number / constant |
| `.s` | string            |
| `.f` | function          |
| `.o` | operator / regex  |
| `.p` | control flow / error |
| `.y` | parameter         |

Markup: `<pre class="ds-code-block">…<span class="k">if</span>…</pre>`. Keep source legibility — do not over-tag every identifier.

Worked references: `examples/vue3-pwa-walkthrough/02-forms-validation.html` and `03-api-validation.html`.

## VISUAL & VOICE RULES — non-negotiable

Echoed from `agents-html-design` SKILL.md § "Rules to never break":

- **No emoji.** Unicode arrows `→ ↑ ↓` OK. `🎉 ✅ ⚡` not OK.
- **No blue-purple gradients.** No full-bleed bg images. No glass / backdrop-filter blur. No rounded-corner-with-left-border-only cards.
- **Borders 1.5px `--g300`.** Not 1px. Not blue-grey.
- **Italic = one word in H1, color `--clay`.** Not whole sentences.
- **Self-contained `.html`.** Paste design tokens inline (copy `colors_and_type.css` `:root` block into `<style>`). Do not `@import`.

**Voice switching (V11):**

- Default: caveman. Drop articles, fragments OK, short synonyms. Right for invariants, status, acceptance criteria, diagram labels.
- Switch to editorial prose when concept needs explanation: rationale, trade-offs, post-mortem narrative, onboarding context.
- Never mix mid-paragraph. Choose per section. Unclear → ask user.

## OUTPUT STRUCTURE RULES

These rules govern every artifact this skill produces. Mirrored verbatim from the upstream `agents-html-comms` repo `AGENTS.md` so the installed skill stays self-contained — no need to fetch external files.

**Single-file artifact:**

- HTML file MUST be self-contained — tokens inline, theme.js inline, no external `<link>` or `@import` to repo CSS/JS.
- May reference other HTML files (cross-artifact links allowed).

**Multi-file artifact (> 1 HTML file — e.g. memo + linked diagram, walkthrough, deck of decks):**

- TOC file at the root of the artifact folder (typically `index.html`).
- Every leaf HTML MUST have a back-link to the TOC.
- Sibling leaves MUST have prev / next book navigation.
- Disabled state for first page's prev and last page's next — render as ghost text, not omitted, so the nav alignment stays consistent.
- Tree depth ≤ 2 (TOC → leaves, or TOC → group → leaves). Deeper trees fragment attention.
- Each leaf is still fully self-contained — inline tokens, inline theme.js, inline syntax palette. A reader who lands on a deep page mid-share must not see a broken artifact.
- A proper, appropriate navigation structure MUST be added — match the size and shape of the page set.
- HTML files MAY reference each other (cross-links inside body copy are fine, in addition to the book nav).

**Worked reference:** `examples/vue3-pwa-walkthrough/` — TOC + 3 sibling leaves, each with book nav top and bottom, back-to-contents link, self-contained tokens and theme.

## EXAMPLES

**1. Stand-up memo**
> User: "Write a Friday stand-up for the billing team — we shipped retries, broke webhooks once, plan to fix idempotency next week."
> Picker → **memo**. Crib doc kit. Sections: TL;DR / Shipped / Incident / Next. Caveman in TL;DR + bullets, editorial for incident narrative.

**2. API dep diagram**
> User: "Draw how the order service talks to billing, inventory, and the notification queue."
> Picker → **diagram**. Doc kit card container. Inline schematic SVG, nodes mono-labeled, edges serif italic. No new SVG drawing beyond connector lines.

**3. Feature mock for review**
> User: "Mock the new pricing page so I can share it in #design before we build it."
> Picker → **mock**. Doc kit card with mono eyebrow `MOCK — NOT FINAL`. Numbered callouts for hot spots. Single HTML file, self-contained.

## INSTALL — clean copy, not symlink

Source of truth = the `agents-html-comms` repo at `skills/agents-html-comms/`. Install pattern is **clean copy** (not symlink) so installed runtime is decoupled from in-progress repo edits. During development, redeploy explicitly after each round of edits — matches how downstream consumers will install the skill.

**User-scope (every project on this machine):**

```bash
git clone https://github.com/grusim/agents-html-comms ~/src/agents-html-comms
cd ~/src/agents-html-comms
./deploy.sh
```

`deploy.sh` wipes `~/.claude/skills/agents-html-comms/` and copies the current repo state into it.

**Project-scope (versioned with one project, via submodule):**

```bash
cd <your-project>
git submodule add https://github.com/grusim/agents-html-comms .agents-html-comms
mkdir -p .claude/skills
cp -R .agents-html-comms/skills/agents-html-comms .claude/skills/agents-html-comms
```

Re-run the copy after each submodule update.

**Manual deploy from anywhere:**

```bash
rm -rf ~/.claude/skills/agents-html-comms
cp -R <repo>/skills/agents-html-comms ~/.claude/skills/agents-html-comms
```

**Design system dependency.** Separate skill `agents-html-design`. Install user-scope per its own `INSTALL.md` (unzip handoff bundle into `~/.claude/skills/agents-html-design/`). Re-export from claude.ai/design and reinstall when the brand contract changes.

**Verify.** Open a new claude session, ask `what skills are available?` — expect `agents-html-comms` AND `agents-html-design` both listed.

Missing `agents-html-design` → this skill aborts (see STEP 0).

## DESIGN SYSTEM = UPSTREAM ZIP, READ-ONLY

`agents-html-design` is the verbatim export from claude.ai/design. Treat it as read-only:

- Brand changes happen in claude.ai/design → re-export zip → drop into `~/.claude/skills/agents-html-design/` (overwriting prior contents).
- Do NOT hand-edit files inside `~/.claude/skills/agents-html-design/`.
- Recurring gaps (something missing from every artifact) → encode the fix here in `agents-html-comms` SKILL.md as a required pattern, with the verbatim crib snippet. The artifact emits the fix; the design system stays untouched.
- One-off artifact tweaks → handle per-prompt at compose time. Do not promote to a SKILL.md rule unless it recurs.

## NON-GOALS

- ! production code. Output = prototype HTML, not React/Vue components.
- ! design tokens copied here. Source of truth = `agents-html-design`.
- ! new SVG drawing beyond trivial connectors.
- ! Markdown output. If user wants markdown, this skill is the wrong tool.
- ! local edits to `~/.claude/skills/agents-html-design/`. Always round-trip through claude.ai/design.
