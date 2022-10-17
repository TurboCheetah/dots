# cat aliases
function cat --wraps bat --description 'alias for bat'
    bat -p $argv
end
