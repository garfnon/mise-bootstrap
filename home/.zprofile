
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"
[ -x /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# mise and starship live here on Linux; .zshrc only runs for interactive shells
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
