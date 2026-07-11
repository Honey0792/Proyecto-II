# Skill Registry

> Auto-generated index. `SKILL.md` files are the source of truth.
> Generated: 2026-07-11

## Contract

- Index only; do not summarize or inject rules from this file.
- Delegators: match by trigger/description, then pass the exact `SKILL.md` path to sub-agents.
- Project-level skills take precedence over user-level skills with the same name.
- Skip `sdd-*`, `_shared`, and `skill-registry` from this index.

## Indexed Skills (11)

| # | Skill | Trigger / Description | Scope | Path |
|---|-------|----------------------|-------|------|
| 1 | branch-pr | Create Gentle AI pull requests with issue-first checks. Trigger: creating, opening, or preparing PRs for review. | user | `C:\Users\DELL\.config\opencode\skills\branch-pr\SKILL.md` |
| 2 | chained-pr | Trigger: PRs over 400 lines, stacked PRs, review slices. Split oversized changes into chained PRs that protect review focus. | user | `C:\Users\DELL\.config\opencode\skills\chained-pr\SKILL.md` |
| 3 | cognitive-doc-design | Design docs that reduce cognitive load. Trigger: writing guides, READMEs, RFCs, onboarding, architecture, or review-facing docs. | user | `C:\Users\DELL\.config\opencode\skills\cognitive-doc-design\SKILL.md` |
| 4 | comment-writer | Write warm, direct collaboration comments. Trigger: PR feedback, issue replies, reviews, Slack messages, or GitHub comments. | user | `C:\Users\DELL\.config\opencode\skills\comment-writer\SKILL.md` |
| 5 | go-testing | Trigger: Go tests, go test coverage, Bubbletea teatest, golden files. Apply focused Go testing patterns. | user | `C:\Users\DELL\.config\opencode\skills\go-testing\SKILL.md` |
| 6 | issue-creation | Create Gentle AI issues with issue-first checks. Trigger: creating GitHub issues, bug reports, or feature requests. | user | `C:\Users\DELL\.config\opencode\skills\issue-creation\SKILL.md` |
| 7 | judgment-day | Trigger: judgment day, dual review, adversarial review, juzgar. Run explicit blind dual review with at most two scoped fix/re-judgment rounds. | user | `C:\Users\DELL\.config\opencode\skills\judgment-day\SKILL.md` |
| 8 | skill-creator | Trigger: new skills, agent instructions, documenting AI usage patterns. Create LLM-first skills with valid frontmatter. | user | `C:\Users\DELL\.config\opencode\skills\skill-creator\SKILL.md` |
| 9 | skill-improver | Trigger: improve skills, audit skills, refactor skills, skill quality. Audit and upgrade existing LLM-first skills. | user | `C:\Users\DELL\.config\opencode\skills\skill-improver\SKILL.md` |
| 10 | vue-vuetify-crud | Patrones y templates para crear componentes Vue 3 con Vuetify usando Options API. Trigger: Cuando se crea un componente Vue con CRUD, formularios, tablas o diálogos. | user | `C:\Users\DELL\.config\opencode\skills\vue-vuetify-crud\SKILL.md` |
| 11 | work-unit-commits | Plan commits as reviewable work units. Trigger: implementation, commit splitting, chained PRs, or keeping tests and docs with code. | user | `C:\Users\DELL\.config\opencode\skills\work-unit-commits\SKILL.md` |

## Skipped

- `_shared` — not invokable (shared references only)
- `sdd-*` (11 skills) — SDD phase skills; managed by orchestrator delegation
- `skill-registry` — this file's own skill

## Sources Scanned

- User skills: `C:\Users\DELL\.config\opencode\skills\`
- Project skills: none found
