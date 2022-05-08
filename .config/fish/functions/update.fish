# update function for managing Debian/Ubuntu servers
function update --wraps apt --description 'alias for apt update, upgrade, autoremove, and autoclean'
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
    sudo apt autoclean
end
