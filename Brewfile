# Homebrew packages that mise cannot provide: the GNU/uutils userland on macOS,
# compiled/system-linked tools, and GUI apps. Language runtimes and
# single-binary CLI tools live in home/.config/mise/config.toml instead.
#
# Regenerate the formula list with:  brew leaves

# mise itself -- bootstraps everything else
brew "mise"

# coreutils and findutils, Rust rewrites -- replace the GNU ones; the unprefixed
# names come from their uubin dirs, put on PATH in home/.zsh_custom_aliases/aliases.
# diffutils stays GNU: uutils-diffutils has no diff -r/-i/-w/--color, diff3 or sdiff.
brew "uutils-coreutils"
brew "uutils-findutils"

# GNU userland (macOS ships BSD variants; the shell functions assume GNU flags)
brew "binutils"
brew "diffutils"
brew "gawk"
brew "gnu-indent"
brew "gnu-sed"
brew "gnu-tar"
brew "gnu-which"
brew "grep"
brew "gzip"
brew "ed"
brew "less"
brew "make"        # GNU make 4.x; macOS ships 3.81
brew "nano"
brew "screen"
brew "watch"
brew "wdiff"
brew "zip"

# build toolchain
brew "autoconf"
brew "flex"
brew "gpatch"

# shells & misc CLI
brew "bash"        # zsh is the login shell; this is bash 5.x for scripts
brew "eza"         # `ll` alias; no macOS release binaries, so not in mise
brew "fastfetch"
brew "starship"    # zsh prompt; oh-my-zsh is only used for plugins
brew "tree"
brew "upx"        # no darwin/arm64 build in mise's aqua package
brew "wget"

# hardware / daemons
brew "docker"
brew "ykman"

cask "bentobox"
cask "bettermouse"
