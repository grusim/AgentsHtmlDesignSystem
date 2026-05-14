# AGENTS.md

Project manifesto. Rules for agent-produced HTML artifacts.

These rules are **mirrored verbatim** into `skills/agents-html-comms/SKILL.md § OUTPUT STRUCTURE RULES` so the installed skill stays self-contained (consumers symlink the skill folder; the repo-root `AGENTS.md` is not visible at runtime). Edit both when changing a rule.

## Rules

- If there are more than one Agent HTML files, there MUST be a TOC
- HTML files must be self-contained
  - IF there is a TOC, there must be a back-link from individual HTML back to the TOC
- Structure: Agents HTML files MAY have a tree structure
  - A proper and appropriate Navigation structure MUST be added, depending on the number and nature of (sub-) HTML pages
  - IF there are related sibling HTML files, there MUST BE a next, previous (book navigation)
  - First page's prev and last page's next MUST render as a disabled / ghost state, not be omitted — keeps the nav rail horizontally aligned
- HTML files can reference each other
