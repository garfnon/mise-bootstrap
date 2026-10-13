# Homebrew packages for macOS: everything except the few version-pinned tools
# in home/.config/mise/config.toml (terraform, kubectl, helm, node, ...). That
# covers general CLI tools, the GNU/uutils userland, compiled/system-linked
# tools, and GUI apps.
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

# shells & misc
brew "starship"    # zsh prompt; oh-my-zsh is only used for plugins
brew "upx"
brew "wget"

# CLI tools -- keep in sync with Brewfile.linux
brew "azure-cli"      # az
brew "bat"            # cat with syntax highlighting
brew "bitwarden-cli"  # bw
brew "bottom"         # btm
brew "direnv"
brew "dust"           # du
# Disabled in Homebrew (unmaintained upstream since 2025-06), so a fresh install fails;
# kept only while already installed, for the Earthfile projects that still use it.
brew "earthly" if File.exist?("#{HOMEBREW_PREFIX}/bin/earthly")
brew "eza"            # `ll` alias
brew "fastfetch"
brew "fd"             # find
brew "fzf"
brew "git-delta"      # git pager, see home/.gitconfig
brew "gnupg"          # Linux gets this from the Aptfile
brew "jq"
brew "k9s"
brew "boz/repo/kail"  # multi-pod log tail; third-party tap, no homebrew-core formula
brew "kind"
brew "kubelogin"      # kubectl oidc-login
brew "minikube"
brew "ouch"           # compress/decompress any archive format
brew "pre-commit"
brew "neovim"
brew "ripgrep"        # rg
brew "sd"             # sed
brew "sevenzip"       # 7zz
brew "sops"
brew "tmux"
brew "tokei"          # `gcloc` alias
brew "uv"
brew "viddy"          # `watch` alias
brew "yamllint"
brew "yq"             # mikefarah's yq, used by the kbbcm alias
brew "zoxide"         # `z`, via the oh-my-zsh plugin

# hardware / daemons
brew "docker"
brew "ykman"

cask "bentobox"
cask "bettermouse"
