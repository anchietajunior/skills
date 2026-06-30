#!/usr/bin/env bash
#
# install.sh — install this pack's skills into Claude Code and/or Codex.
#
# Both tools read the SKILL.md open standard, so the same skills/<name>/
# directory serves both — only the discovery path differs:
#
#   Claude Code   personal: ~/.claude/skills    project: <proj>/.claude/skills
#   Codex         personal: ~/.agents/skills    project: <proj>/.agents/skills
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"

TOOL="both"
MODE="symlink"
PROJECT=""
FORCE=0
LIST=0
SELECTED=()

show_help() {
  cat <<'EOF'
Usage: ./scripts/install.sh [options]

Install this pack's skills into Claude Code and/or Codex.

Options:
  --tool <claude|codex|both>   Target tool(s). Default: both
  --mode <symlink|copy>        symlink (tracks git pull) or copy (snapshot).
                               Default: symlink
  --project <path>             Install into a project's dir instead of the
                               personal dir (.claude/skills / .agents/skills)
  --skill <name>               Install only this skill (repeatable). Default: all
  --force                      Replace existing entries
  --list                       List available skills and exit
  -h, --help                   Show this help

Discovery paths:
  Claude Code   personal: ~/.claude/skills     project: <proj>/.claude/skills
  Codex         personal: ~/.agents/skills     project: <proj>/.agents/skills
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --tool)    TOOL="${2:-}"; shift 2;;
    --mode)    MODE="${2:-}"; shift 2;;
    --project) PROJECT="${2:-}"; shift 2;;
    --skill)   SELECTED+=("${2:-}"); shift 2;;
    --force)   FORCE=1; shift;;
    --list)    LIST=1; shift;;
    -h|--help) show_help; exit 0;;
    *) echo "Unknown option: $1" >&2; show_help >&2; exit 2;;
  esac
done

case "$TOOL" in claude|codex|both) ;; *) echo "Invalid --tool: $TOOL" >&2; exit 2;; esac
case "$MODE" in symlink|copy) ;; *) echo "Invalid --mode: $MODE" >&2; exit 2;; esac

if [ ! -d "$SKILLS_DIR" ]; then
  echo "No skills/ directory found at $SKILLS_DIR" >&2
  exit 1
fi

# Collect skill source dirs (those containing a SKILL.md).
skill_srcs=()
for src in "$SKILLS_DIR"/*/; do
  [ -d "$src" ] || continue
  src="${src%/}"
  name="$(basename "$src")"
  if [ ${#SELECTED[@]} -gt 0 ]; then
    match=0
    for want in "${SELECTED[@]}"; do [ "$want" = "$name" ] && match=1; done
    [ "$match" -eq 1 ] || continue
  fi
  if [ ! -f "$src/SKILL.md" ]; then
    echo "  ! $name has no SKILL.md, skipping" >&2
    continue
  fi
  skill_srcs+=("$src")
done

if [ ${#skill_srcs[@]} -eq 0 ]; then
  echo "No matching skills found." >&2
  exit 1
fi

if [ "$LIST" -eq 1 ]; then
  echo "Available skills:"
  for src in "${skill_srcs[@]}"; do echo "  - $(basename "$src")"; done
  exit 0
fi

# Warn about requested skills that don't exist.
if [ ${#SELECTED[@]} -gt 0 ]; then
  for want in "${SELECTED[@]}"; do
    found=0
    for src in "${skill_srcs[@]}"; do [ "$(basename "$src")" = "$want" ] && found=1; done
    [ "$found" -eq 1 ] || echo "  ! requested skill not found: $want" >&2
  done
fi

tools=()
case "$TOOL" in
  claude) tools=(claude);;
  codex)  tools=(codex);;
  both)   tools=(claude codex);;
esac

target_dir_for() {
  local tool="$1" base
  base="${PROJECT:-$HOME}"
  case "$tool" in
    claude) printf '%s/.claude/skills' "$base";;
    codex)  printf '%s/.agents/skills' "$base";;
  esac
}

install_one() {
  local src="$1" dest="$2" name link current
  name="$(basename "$src")"
  link="$dest/$name"

  if [ -L "$link" ] || [ -e "$link" ]; then
    if [ "$MODE" = "symlink" ] && [ -L "$link" ]; then
      current="$(readlink "$link")"
      if [ "$current" = "$src" ]; then echo "  = $name (up to date)"; return; fi
    fi
    if [ "$FORCE" -eq 1 ]; then
      rm -rf "$link"
    else
      echo "  ! $name exists, skipping (use --force to replace): $link"; return
    fi
  fi

  if [ "$MODE" = "symlink" ]; then
    ln -s "$src" "$link"; echo "  + $name (symlink)"
  else
    cp -R "$src" "$link"; echo "  + $name (copy)"
  fi
}

for tool in "${tools[@]}"; do
  dest="$(target_dir_for "$tool")"
  label="Claude Code"; [ "$tool" = "codex" ] && label="Codex"
  echo "$label -> $dest"
  mkdir -p "$dest"
  for src in "${skill_srcs[@]}"; do install_one "$src" "$dest"; done
  echo
done

echo "Done. Verify with:"
for tool in "${tools[@]}"; do
  if [ "$tool" = "claude" ]; then
    echo "  Claude Code: restart, then run /<skill-name> (e.g. /teach)"
  else
    echo "  Codex: run /skills to list, or invoke \$<skill-name> (e.g. \$teach)"
  fi
done
