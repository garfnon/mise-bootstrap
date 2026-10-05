#!/usr/bin/env bash
# Fresh-machine entry point. Everything after this is a mise task.
#
#   curl -fsSL <raw-url>/bootstrap.sh | bash
# or, with the repo already cloned:
#   ./bootstrap.sh
#
# Supports macOS and Debian/Ubuntu.
set -euo pipefail

REPO_URL="${BOOTSTRAP_REPO:-https://github.com/garfnon/mise-bootstrap.git}"
REPO_DIR="${BOOTSTRAP_DIR:-$HOME/git/mise-bootstrap}"

as_root() { if [ "$(id -u)" -eq 0 ]; then "$@"; else sudo "$@"; fi; }

case "$(uname -s)" in
  Darwin)
    # 1. Xcode CLT -- git and a compiler
    xcode-select -p >/dev/null 2>&1 || { echo "==> Installing Xcode Command Line Tools"; xcode-select --install; \
      until xcode-select -p >/dev/null 2>&1; do sleep 5; done; }

    # 2. Homebrew -- mise's own installer
    if ! command -v brew >/dev/null 2>&1; then
      echo "==> Installing Homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # 3. mise
    command -v mise >/dev/null 2>&1 || { echo "==> Installing mise"; brew install mise; }
    ;;
  Linux)
    command -v apt-get >/dev/null 2>&1 || { echo "only Debian/Ubuntu (apt) is supported on Linux" >&2; exit 1; }

    # 1. git, curl and a compiler -- the rest of the apt list is in tasks/brew
    echo "==> Installing base packages"
    as_root apt-get update -qq
    as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y -qq git curl ca-certificates build-essential

    # 2. mise -- its own installer, into ~/.local/bin (no Homebrew on Linux)
    export PATH="$HOME/.local/bin:$PATH"
    command -v mise >/dev/null 2>&1 || { echo "==> Installing mise"; curl -fsSL https://mise.run | sh; }
    ;;
  *)
    echo "unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

# 4. this repo
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "==> Cloning bootstrap repo"
  mkdir -p "$(dirname "$REPO_DIR")"
  git clone "$REPO_URL" "$REPO_DIR"
fi

# 5. hand off to mise
cd "$REPO_DIR"
mise trust
exec mise run bootstrap
