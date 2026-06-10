# skills

A personal pack of **agent skills** for [Claude Code](https://claude.com/claude-code) **and [Codex](https://developers.openai.com/codex/skills)** — reusable, invokable workflows that package a process (when to trigger, the steps, checklists, expected output) into a single self-contained Markdown file. There is no application code or build system here: the skills *are* the source.

Every skill follows the **`SKILL.md` open standard** (YAML frontmatter with `name` + `description`, a Markdown body, optional `references/`, `templates/`, `scripts/`). Because both Claude Code and Codex read that same standard, **one skill directory works in both tools** — only the install location differs. See [CLAUDE.md](CLAUDE.md) for the authoring conventions.

## Available skills

| Skill | Command | What it does |
|-------|---------|--------------|
| [mastery-research](skills/mastery-research/SKILL.md) | `/mastery-research` · `$mastery-research` | Deeply researches a subject, validates it against the current market, picks authoritative sources, and writes a 21-section `CONTEXT.md` learning package for the `mastery-present` skill to consume. Researches only — it does **not** generate the final tutorial/HTML. |
| [mastery-present](skills/mastery-present/SKILL.md) | `/mastery-present` · `$mastery-present` | Consumes a `mastery-research` `CONTEXT.md` and builds one self-contained `index.html` — a calm, long-form study guide with explanations, examples, mistakes, exercises, checkpoints, a capstone, and a retention plan. Presents only — it does **not** research the subject. |

> This table is the source of truth for what's in this pack. Keep it in sync with the `skills/` directory whenever a skill is added, removed, or renamed.

## Installing skills

Each tool discovers skills in its own directories — a personal one (all projects) and a project-scoped one (one repo):

| Tool | Personal (all projects) | Project-scoped (one repo) | Invoke |
|------|-------------------------|---------------------------|--------|
| **Claude Code** | `~/.claude/skills/<name>/` | `<project>/.claude/skills/<name>/` | `/<name>` |
| **Codex** | `~/.agents/skills/<name>/` | `<project>/.agents/skills/<name>/` | `$<name>` or `/skills` |

A skill is just its directory. You install it by placing (linking) that directory into the location your tool reads. The directory name becomes the command.

### Quick install (script)

After cloning, the bundled script installs every skill into both tools at once:

```bash
~/code/skills/scripts/install.sh            # both tools, symlinked, personal dirs
~/code/skills/scripts/install.sh --list     # list available skills
~/code/skills/scripts/install.sh --tool codex --mode copy
~/code/skills/scripts/install.sh --project ~/work/my-repo   # project-scoped
~/code/skills/scripts/install.sh --help     # all options (--skill, --force, ...)
```

Prefer to do it by hand, or want to understand what the script does? The manual steps below are equivalent.

### 1. Clone this repo

```bash
git clone https://github.com/anchietajunior/skills.git ~/code/skills
```

This location is just a source checkout — **neither Claude Code nor Codex scans `~/code/skills`** (or any path other than the ones in the table above). Cloning alone does nothing; the next step is what actually registers a skill by linking it into a discovery path. Don't clone straight into a skills directory, either — the repo's `skills/<name>/` layout would nest one level too deep.

### 2. Install a single skill

Symlinking is recommended — the skill stays current every time you `git pull`. Pick the line(s) for the tool(s) you use:

```bash
# Claude Code (personal)
mkdir -p ~/.claude/skills
ln -s ~/code/skills/skills/mastery-research ~/.claude/skills/mastery-research

# Codex (personal)
mkdir -p ~/.agents/skills
ln -s ~/code/skills/skills/mastery-research ~/.agents/skills/mastery-research
```

Prefer a static snapshot that won't track updates? Use `cp -r` instead of `ln -s`.

### 3. Install all skills at once

Set `TARGET` to the discovery dir for your tool, then run the loop. Run it once per tool to install into both:

```bash
TARGET=~/.claude/skills      # Claude Code  —  or:  TARGET=~/.agents/skills  (Codex)
mkdir -p "$TARGET"
for d in ~/code/skills/skills/*/; do
  ln -s "$d" "$TARGET/$(basename "$d")"
done
```

### Project-scoped install

Swap the personal dir for the project one in any command above — `<project>/.claude/skills/` (Claude Code) or `<project>/.agents/skills/` (Codex) — to make a skill available only inside that repo, and shareable with a team via the project's own git history.

### Verify

- **Claude Code:** start (or restart) Claude Code and run `/mastery-research`.
- **Codex:** run `/skills` to list discovered skills, or invoke `$mastery-research` directly.

If a skill doesn't appear, confirm its directory contains a `SKILL.md` with valid frontmatter and that it's under the right discovery path for your tool.

## Creating a new skill

Use the `write-a-skill` skill, then follow the conventions and standing rules in [CLAUDE.md](CLAUDE.md) — notably: confirm pt-br/English first, interview before authoring, and keep every skill **portable across Claude Code and Codex** (standard `SKILL.md`, tool-neutral wording, no hard dependency on a tool-specific skill).

## License

Personal project — reuse and adapt freely.
