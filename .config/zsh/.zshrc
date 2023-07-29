# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Environment variables
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export LC_ALL="en_US.UTF-8"
export GPG_TTY=$(tty)
export _JAVA_AWT_WM_NONREPARENTING=1
export FZF_DEFAULT_OPTS="--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PATH:$PNPM_HOME"
export PATH="$PATH:$HOME/.bun/bin"

# Load plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/completions"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Load aliases
source ~/.config/zsh/aliases.zsh

eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/zsh/prompt.omp.json)"
