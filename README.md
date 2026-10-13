# bootstrap

Reproducible macOS environment, orchestrated by [mise](https://mise.jdx.dev).

## Fresh machine

```sh
curl -fsSL https://raw.githubusercontent.com/garfnon/mise-bootstrap/main/bootstrap.sh | bash
```

That installs Xcode CLT → Homebrew → mise on macOS (base apt packages → Homebrew → mise
on Debian/Ubuntu), clones this repo, then runs `mise run bootstrap`.

## Day to day

```sh
mise tasks                    # list everything
mise run bootstrap            # full run (idempotent)
mise run doctor               # verify current state
mise run link                 # re-link dotfiles after adding a file to home/
mise run snapshot             # pull package drift back into this OS's Brewfile
```

## How the pieces divide

Homebrew is the default. mise holds only the tools where the exact version
matters:

| | lives in | why |
|---|---|---|
| version-sensitive infrastructure CLIs and runtimes (terraform, terragrunt, kubectl, helm, flux2, istioctl, kustomize, node) | `home/.config/mise/config.toml` | pinned to an exact version, identical on both OSes, overridable per project |
| everything else: general CLI tools (ripgrep, fzf, neovim, tmux, k9s), uutils coreutils/findutils, GNU userland, casks | `Brewfile` (macOS) | always the latest release; nothing to bump by hand |
| system packages on Debian/Ubuntu | `Aptfile`, then `Brewfile.linux` for the same CLI tools as macOS | Linux already has the GNU userland; uutils coreutils/findutils come from brew until the distro ships them; no casks |

`kail` comes from the third-party `boz/repo` Homebrew tap (declared in both
Brewfiles), since it isn't version-sensitive.

> **When adding a tool,** ask whether a version mismatch would break something
> (a cluster, a state file, a project's lockfile). If yes, it goes in mise. If
> not, it goes in both Brewfiles.

## Layout

```
mise.toml                 task orchestrator (tasks only — no [tools])
Brewfile                  everything not version-pinned in mise (macOS)
Brewfile.linux            the same CLI tools on Linux, via Linuxbrew
Aptfile                   Debian/Ubuntu system packages
bootstrap.sh              fresh-machine entry point
home/                     mirrored into $HOME as symlinks by `mise run link`
  .zshrc ...              shell (Starship prompt; oh-my-zsh for plugins only)
  .config/starship.toml   prompt config
  .config/mise/config.toml   ← the version-pinned tool list
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
- **a brew package** (the default) — `brew install <pkg>`, then `mise run snapshot`, and add it to the other OS's Brewfile
- **a version-pinned tool** — `mise use -g <tool>@<version>`, which writes through the symlink to `home/.config/mise/config.toml`
