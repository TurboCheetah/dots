# update function for managing Debian/Ubuntu servers
function update --wraps nala --description 'alias for nala upgrade'
    sudo nala upgrade
end
