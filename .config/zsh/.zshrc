# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Load zgen
source "${HOME}/.dootfiles/zsh/zgen/zgen.zsh"
ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${HOME}/.zshrc.local ${HOME}/.dotfiles/zsh/zshrc )
# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen load denysdovhan/spaceship-zsh-theme spaceship
  zgen load zsh-users/zsh-completions

  plugins=(git zsh-autosuggestions zsh-syntax-highlighting common-aliases docker-compose extract gh sudo transfer screen)
  for p in ${(@s' ')plugins}; do
  	zgen oh-my-zsh plugins/$p
  done

  # generate the init script from plugins above
  zgen save
fi


DISABLE_UPDATE_PROMPT=true
source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
unsetopt nomatch
SPACESHIP_USER_SHOW=needed
SPACESHIP_HOST_SHOW=false
SPACESHIP_DIR_TRUNC_PREFIX="~/"
alias update="sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt autoclean"
alias yay="paru"
alias rcp="rsync -avh --progress $1 $2"
alias pcp="rsync -avh --progress /mnt/local/raid/downloads/torrents/rutorrent/completed/Porn/* /mnt/unionfs/Media/Adult/ && find /mnt/unionfs/Media/Adult/ -name "RARBG*" -type f -delete"
alias qpcp="rsync -avh --progress /mnt/local/raid/downloads/torrents/qbittorrent/completed/Porn/* /mnt/unionfs/Media/Adult/ && find /mnt/unionfs/Media/Adult/ -name "RARBG*" -type f -delete"
alias nmon="speedometer -r enp3s0f1 -t enp3s0f1 -s"
alias ctdl="cd /mnt/local/raid/downloads/torrents/qbittorrent/completed/$1"
alias cndl="cd /mnt/local/downloads/nzbs/nzbget/completed/$1"
alias dprune="docker system prune -af --volumes"
alias ls="exa -G --icons"
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# cloudplow aliases
alias cplog="tail /opt/cloudplow/cloudplow.log -f"

# Include Z
. /opt/z/z.sh
