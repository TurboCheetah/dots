export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Vim mode
bindkey -v

# fzf
# zi ice from"gh-r" as"program"
# zi light junegunn/fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

# load completions
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/history-search-multi-word \
    zsh-users/zsh-history-substring-search \
    unixorn/fzf-zsh-plugin

# Generate completions from manpages
zstyle ':completion:*'      menu yes select
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# Load starship theme
zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zinit light starship/starship

eval "$(zoxide init zsh)"

# Disable ZSH update prompt
DISABLE_UPDATE_PROMPT=true

export EDITOR=nvim
unsetopt nomatch
alias update="sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt autoclean"
alias yay="paru"
alias rcp="rsync -rlptHhv --progress --safe-links $1 $2"
alias pcp="rsync -avh --progress /mnt/local/raid/downloads/torrents/rutorrent/completed/Porn/* /mnt/unionfs/Media/Adult/ && find /mnt/unionfs/Media/Adult/ -name "RARBG*" -type f -delete"
alias qpcp="rsync -avh --progress /mnt/local/raid/downloads/torrents/qbittorrent/completed/Porn/* /mnt/unionfs/Media/Adult/ && find /mnt/unionfs/Media/Adult/ -name "RARBG*" -type f -delete"
alias nmon="speedometer -r enp3s0f1 -t enp3s0f1 -s"
alias ctdl="cd /mnt/local/raid/downloads/torrents/qbittorrent/completed/$1"
alias cndl="cd /mnt/local/downloads/nzbs/nzbget/completed/$1"
alias dprune="docker system prune -af --volumes"
alias ls="exa -G --icons"
alias lf="lfub"
# cloudbox aliases
alias cpu="screen -dmS "cloudplow" cloudplow upload"
cloudbox() {
  cd ~/cloudbox/;
  sudo ansible-playbook cloudbox.yml --tags $1;
  cd -;
}
cloudbox-list() {
  cd ~/cloudbox/;
  sudo ansible-playbook cloudbox.yml --list-tags;
  cd -;
}
cloudbox-update() {
  curl -s https://cloudbox.works/scripts/dep.sh | sudo -H sh; 
  curl -s https://cloudbox.works/scripts/repo.sh | bash;
  cd ~/cloudbox/;
  sudo ansible-playbook cloudbox.yml --tags cloudbox;
  cd -;
}
# community aliases
community() {
  cd ~/community/;
  sudo ansible-playbook community.yml --tags $1;
  cd -;
}
community-list() {
  cd ~/community/;
  sudo ansible-playbook community.yml --list-tags;
  cd -;
}
community-update() {
  curl -s https://cloudbox.works/scripts/dep.sh | sudo -H sh;
  curl -s https://cloudbox.works/scripts/repo.sh | bash;
  cd ~/cloudbox/;
  sudo ansible-playbook cloudbox.yml --tags community;
  cd -;
}

# cloudplow aliases
alias cplog="tail /opt/cloudplow/cloudplow.log -f"

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

