# skills

A personal pack of **agent skills** for [Claude Code](https://claude.com/claude-code) — reusable, invokable workflows that package a process (when to trigger, the steps, checklists, expected output) into a single self-contained Markdown file. There is no application code or build system here: the skills *are* the source.

Each skill lives in `skills/<skill-name>/` with a `SKILL.md` entry point and optional `references/`, `templates/`, and `scripts/`. See [CLAUDE.md](CLAUDE.md) for the authoring conventions.

## Available skills

| Skill | Command | What it does |
|-------|---------|--------------|
| [mastery-research](skills/mastery-research/SKILL.md) | `/mastery-research` | Deeply researches a subject, validates it against the current market, picks authoritative sources, and writes a 21-section `CONTEXT.md` learning package for the `mastery-present` skill to consume. Researches only — it does **not** generate the final tutorial/HTML. |

> This table is the source of truth for what's installed. Keep it in sync with the `skills/` directory whenever a skill is added, removed, or renamed.

## Installing skills

Claude Code discovers skills in two places:

- **Personal (all projects):** `~/.claude/skills/<skill-name>/`
- **Project-scoped (one repo):** `<project>/.claude/skills/<skill-name>/`

A skill is just its directory — install it by putting that directory in one of those locations. The directory name becomes the `/command`.

### 1. Clone this repo

```bash
git clone https://github.com/anchietajunior/skills.git ~/code/skills
```

This location is just a source checkout — **Claude Code does not scan `~/code/skills`** (or any path other than the two above). Cloning alone does nothing; the next step is what actually registers a skill by linking it into a discovery path. Don't clone straight into `~/.claude/skills/`, either — the repo's `skills/<name>/` layout would nest one level too deep.

### 2. Install a single skill

**Symlink (recommended)** — stays current every time you `git pull`:

```bash
ln -s ~/code/skills/skills/mastery-research ~/.claude/skills/mastery-research
```

**Copy** — a static snapshot, won't track updates:

```bash
cp -r ~/code/skills/skills/mastery-research ~/.claude/skills/
```

### 3. Install all skills at once

```bash
mkdir -p ~/.claude/skills
for d in ~/code/skills/skills/*/; do
  ln -s "$d" ~/.claude/skills/"$(basename "$d")"
done
```

### Project-scoped install

Swap `~/.claude/skills/` for `<project>/.claude/skills/` in any command above to make a skill available only inside that repo (handy for sharing with a team via the project's own git history).

### Verify

Start (or restart) Claude Code in a project and run the skill's command, e.g. `/mastery-research`. If it doesn't appear, confirm the directory contains a `SKILL.md` with valid frontmatter and that the path is correct.

## Creating a new skill

Use the `write-a-skill` skill, then follow the conventions and standing rules in [CLAUDE.md](CLAUDE.md) (notably: confirm pt-br/English first, and interview before authoring).

## License

Personal project — reuse and adapt freely.
