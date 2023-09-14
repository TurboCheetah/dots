# ls alias
function ls --wraps exa --description 'alias for exa to replace ls'
    eza -G --icons $argv
end
