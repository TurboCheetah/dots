# ls alias
function ls --wraps exa --description 'alias for exa to replace ls'
    exa -G --icons $argv
end