# update function for managing Debian/Ubuntu servers
function update --wraps apt --description 'alias for apt update, upgrade, autoremove, and autoclean'
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
    sudo apt autoclean
end

# rsync alias
function rcp --wraps rsync --description 'alias for rsync'
    rsync -rlptHhv --progress --safe-links $argv
end

# ls alias
function ls --wraps exa --description 'alias for exa to replace ls'
    exa -G --icons $argv
end

# cloudbox aliases
alias cpu="screen -dmS "cloudplow" cloudplow upload"
alias cplog="tail /opt/cloudplow/cloudplow.log -f"