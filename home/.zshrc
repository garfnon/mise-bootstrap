# Path to your oh-my-zsh installation.
export ZSH="$HOME/.omz"

# Set name of the theme to load --- if set to "random", it will
ZSH_THEME=""  # prompt handled by Starship (see end of file)

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Disable auto updates for Chezmoi to handle them
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# History
HISTCONTROL=ignoreboth
HISTSIZE=1000000

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(alias-finder direnv docker docker-compose fzf git gitfast helm httpie kubectl sudo z zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

# Turn on Alias-finder
ZSH_ALIAS_FINDER_AUTOMATIC=true

# Add dotfile completions to FPATH -> Must be _BEFORE_ sourcing oh my zsh <-
export FPATH=$FPATH:$HOME/.omz/custom/plugins/extra-completions/

# If $HOME/.omz/custom/plugins/custom-completions folder exists, source the files therein
# This is useful if you want to setup some custom completions, because writing to _this file_ 
# will be overridden next time you run the dots
if [[ -d "$HOME/.omz/custom/plugins/custom-completions" ]]; then
  export FPATH=$FPATH:$HOME/.omz/custom/plugins/custom-completions/
fi

# mise-installed tools (fzf, direnv) must be on PATH before the plugins above
# load; full `mise activate` happens later via ~/.zsh_custom_exports/mise
[[ -d "$HOME/.local/share/mise/shims" ]] && export PATH="$HOME/.local/share/mise/shims:$PATH"

# Source Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Source additional Zsh config files
source $HOME/.zsh_functions
source $HOME/.zsh_aliases
source $HOME/.zsh_exports

# Load zsh completions
autoload -U +X bashcompinit && bashcompinit

# Load AWS completion
complete -C '$(command -v aws_completer)' aws

# Prompt: Starship (config in ~/.config/starship.toml). Keep this last.
eval "$(starship init zsh)"
