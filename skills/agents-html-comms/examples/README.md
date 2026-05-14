# examples

Worked artifacts from past invocations of `agents-html-comms`. Each entry pairs a use-case with a self-contained HTML file.

Empty for now. As real artifacts get produced, drop them here and add a line to the index below.

## Index

| Entry | Use-case | Notes |
|-------|----------|-------|
| [`vue3-pwa-walkthrough/`](./vue3-pwa-walkthrough/) | multi-page walkthrough | Three interlinked pages covering architecture, client-side forms / validation, and backend validation. Demonstrates V5 multi-file output: TOC at `index.html`, prev/next book nav + back-to-TOC on every page. Each page is also self-contained (V3). |
| ↳ [`index.html`](./vue3-pwa-walkthrough/index.html) | TOC | 3-card grid + linear reading rail. |
| ↳ [`01-architecture.html`](./vue3-pwa-walkthrough/01-architecture.html) | architecture diagram | Runtime + build-time bands. Service Worker, Swashbuckle, openapi-ts. |
| ↳ [`02-forms-validation.html`](./vue3-pwa-walkthrough/02-forms-validation.html) | spec explainer | Client-side validation: schema, rule taxonomy, four field states, Vue 3 + vee-validate + Zod code. |
| ↳ [`03-api-validation.html`](./vue3-pwa-walkthrough/03-api-validation.html) | spec explainer | Backend FluentValidation, ProblemDetails 400, round-trip diagram, mapping server errors to form fields, anti-patterns. |
