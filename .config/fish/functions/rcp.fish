# rsync alias
function rcp --wraps rsync --description 'alias for rsync'
    rsync -rlptHhv --progress --safe-links $argv
end