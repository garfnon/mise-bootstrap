# bootstrap

Reproducible macOS environment, orchestrated by [mise](https://mise.jdx.dev).

## Fresh machine

```sh
curl -fsSL https://raw.githubusercontent.com/garfnon/mise-bootstrap/main/bootstrap.sh | bash
```

That installs Xcode CLT → Homebrew → mise, clones this repo, then runs `mise run bootstrap`.

## Day to day

```sh
mise tasks                    # list everything
mise run bootstrap            # full run (idempotent)
mise run doctor               # verify current state
mise run link                 # re-link dotfiles after adding a file to home/
mise run snapshot             # pull package drift back into the Brewfile
```

## How the pieces divide

mise is **not** a Homebrew wrapper — it has its own backends (`aqua`, `ubi`,
`pypi`, `npm`, `cargo`, `github`, …) and pulls prebuilt release binaries directly.
So the split is by what each tool is actually good at:

| | lives in | why |
|---|---|---|
| language runtimes, single-binary CLIs (kubectl, terraform, helm, node, nvim, tmux) | `home/.config/mise/config.toml` | versioned, per-project overridable, no compile step |
| GNU userland, compiled/system-linked tools, casks (gnu-sed, coreutils, docker, ykman) | `Brewfile` | mise has no backend for these |

Three deliberate exceptions are documented inline in `home/.config/mise/config.toml`:
`upx`, `make` and `coreutils` stay on brew.

> **Before moving anything else off brew:** a mise registry entry is not proof of
> platform support. `upx` resolves a version via `mise ls-remote` but the aqua
> package ships linux and windows/amd64 only — it fails at install time on
> darwin/arm64. Always run the install, not just the lookup.

## Layout

```
mise.toml                 task orchestrator (tasks only — no [tools])
Brewfile                  packages mise can't provide
bootstrap.sh              fresh-machine entry point
home/                     mirrored into $HOME as symlinks by `mise run link`
  .zshrc ...              shell (Starship prompt; oh-my-zsh for plugins only)
  .config/starship.toml   prompt config
  .config/mise/config.toml   ← the global tool list
  .config/nvim/           LazyVim + lazy-lock.json
tasks/                    one executable per task
```

## Dotfiles are symlinks

`mise run link` walks every **file** under `home/` and symlinks it to the same
path under `$HOME`, creating parent directories as needed. File-level (not
directory-level) linking means `~/.config` keeps holding unmanaged state
alongside managed config.

Anything it replaces is moved to `~/.bootstrap-backup/<timestamp>/` first.

Because the links point back here, editing `~/.zshrc` edits `home/.zshrc` in this
repo. There is no "capture" step for dotfiles — `git diff` shows your changes.

## Adding things

- **a dotfile** — put it under `home/`, run `mise run link`
- **a mise tool** — `mise use -g <tool>@<version>`, which writes through the symlink to `home/.config/mise/config.toml`
- **a brew package** — `brew install <pkg>`, then `mise run snapshot`
