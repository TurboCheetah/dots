# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Load Antidote
# clone antidote if necessary and generate a static plugin file
zhome=${ZDOTDIR:-$HOME}
if [[ ! $zhome/.zsh_plugins.zsh -nt $zhome/.zsh_plugins.txt ]]; then
  [[ -e $zhome/.antidote ]] \
    || git clone --depth=1 https://github.com/mattmc3/antidote.git $zhome/.antidote
  [[ -e $zhome/.zsh_plugins.txt ]] || touch $zhome/.zsh_plugins.txt
  (
    source $zhome/.antidote/antidote.zsh
    antidote bundle <$zhome/.zsh_plugins.txt >$zhome/.zsh_plugins.zsh
  )
fi

# uncomment if you want your session to have commands like `antidote update`
# autoload -Uz $zhome/.antidote/functions/antidote

# source static plugins file
source $zhome/.zsh_plugins.zsh
unset zhome

# start Starship prompt
eval "$(starship init zsh)"

DISABLE_UPDATE_PROMPT=true

# Fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
