#!/usr/bin/env bash
# Shared helpers for bootstrap tasks.
set -euo pipefail

ROOT="${BOOTSTRAP_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
HOME_SRC="$ROOT/home"
BACKUP_DIR="$HOME/.bootstrap-backup/$(date +%Y%m%d-%H%M%S)"

info()  { printf '\033[0;34m==>\033[0m %s\n' "$*"; }
ok()    { printf '  \033[0;32m✓\033[0m %s\n' "$*"; }
warn()  { printf '  \033[0;33m!\033[0m %s\n' "$*"; }
skip()  { printf '  \033[0;90m-\033[0m %s\n' "$*"; }
die()   { printf '\033[0;31m✗\033[0m %s\n' "$*" >&2; exit 1; }

# backup <path> -- move an existing real file/dir out of the way, preserving it
backup() {
  local target="$1"
  [ -e "$target" ] || [ -L "$target" ] || return 0
  mkdir -p "$BACKUP_DIR/$(dirname "${target#"$HOME"/}")"
  mv "$target" "$BACKUP_DIR/${target#"$HOME"/}"
  warn "backed up ${target#"$HOME"/} -> ${BACKUP_DIR#"$HOME"/}"
}

have() { command -v "$1" >/dev/null 2>&1; }

is_mac()   { [ "$(uname -s)" = Darwin ]; }
is_linux() { [ "$(uname -s)" = Linux ]; }

# sudo only when not already root (containers, fresh VMs)
as_root() { if [ "$(id -u)" -eq 0 ]; then "$@"; else sudo "$@"; fi; }

# the Brewfile for this OS -- macOS and Linux keep separate package lists
if is_linux; then BREWFILE="$ROOT/Brewfile.linux"; else BREWFILE="$ROOT/Brewfile"; fi
