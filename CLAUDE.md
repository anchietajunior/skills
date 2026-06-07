# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A personal pack of **agent skills** — reusable, invokable workflows used by the owner (a software engineer and professor) in Claude Code, and meant to be shared with others. Each skill is a self-contained Markdown file that packages a process: when to trigger, the steps to follow, checklists, and the expected output. There is no application code, build system, or test suite — the skills *are* the source.

See [README.md](README.md) for the human-facing catalog of available skills and installation instructions.

## Standing rules for this repo

These override default behavior and apply to every session:

1. **Language check first.** Whenever a skill is being **created or used**, ask whether to interact in **pt-br or English** before proceeding. Skill content here is frequently written in Portuguese.
2. **Interview before authoring.** When creating a new skill, ask the owner relevant questions about its objective until the purpose, trigger, and scope are 100% clear and unambiguous. Never scaffold a skill from a vague request — clarify first.
3. **Keep the README current.** Whenever a skill is added, removed, or renamed, update the skills catalog table in [README.md](README.md) in the same change (and the install examples if a skill name changed). The README must always reflect the actual contents of `skills/`.
4. **Cross-tool by default (Claude Code + Codex).** Every skill must work in **both** Claude Code and Codex. Both read the same `SKILL.md` open standard, so author **one** skill — never fork per tool. To stay portable: (a) use only the standard frontmatter (`name`, `description`) and standard subfolders (`references/`, `templates/`, `scripts/`); (b) keep invocation wording tool-neutral in the `description` (`/skill` in Claude Code, `$skill` in Codex); (c) **never hard-depend on a tool-specific skill or tool** — degrade gracefully (e.g. "use the `deep-research` skill if available, otherwise the host's built-in web search"). Only the install path differs between tools (see [README.md](README.md)).

## Skill format

Each skill lives in its own directory under `skills/`, with a `SKILL.md` entry point and any bundled resources alongside it:

```
skills/
  <skill-name>/
    SKILL.md            # required: frontmatter + workflow
    references/         # optional: checklists, deep-dive docs
    templates/          # optional: output scaffolds
    scripts/            # optional: helper scripts
```

`SKILL.md` opens with YAML frontmatter:

```yaml
---
name: <kebab-case-id, matches the /command and the directory name>
description: Use when <trigger>. <One-line summary of what it does.>
---
```

Keep `SKILL.md` lean and push detail into bundled `references/` files, loaded only when the skill runs (progressive disclosure).

The same `skills/<name>/` directory installs into both tools — Claude Code reads `~/.claude/skills/` (or `<project>/.claude/skills/`); Codex reads `~/.agents/skills/` (or `<project>/.agents/skills/`). See [README.md](README.md) for installation.

Recommended conventions for skills in this pack:

- **`description` encodes the trigger, not just a summary** — e.g. "Use when the user invokes /foo command." The model reads this to decide when to activate, so make activation conditions explicit, including when *not* to use the skill.
- **Body structure**: Overview → When to Use (with hard preconditions) → execution flow (often a Graphviz `dot` diagram) → checklists grouped by category → output format → numbered Execution steps → References.
- **Preconditions are enforced as stop conditions.** A skill checks state (e.g. current git branch, presence of a diff) and halts with a clear message rather than proceeding on invalid input.
- **Opinionated and authority-anchored.** Guidance is attributed to named practitioners and real codebases rather than stated as generic advice.
- **Output is a no-praise audit by default** (in review-style skills): list only problems and suggestions, never confirm what is already correct.
- Content mixes Portuguese and English freely; match the language already used in the file you are editing.

## Working in this repo

This is a content repo with no toolchain — there is no build, lint, or test step. Work is done with `git` and by invoking skills inside Claude Code. A skill is "tested" by running its `/command` and confirming the flow, stop conditions, and output format behave as written.
