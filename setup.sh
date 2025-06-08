#!/bin/bash


# From: https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
    SOURCE=$(readlink "$SOURCE")
    [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

echo $DIR

echo $DIR > ~/.dotfileslocation
cat ~/.dotfileslocation

cd ~/

declare -a FILES=(".zshrc" ".roboguard_aliases")
for FILE in "${FILES[@]}"; do
    if [[ -f "$FILE" ]]; then
        echo Found ${FILE}!
        # From: https://unix.stackexchange.com/questions/167610/determining-if-a-file-is-a-hard-link-or-symbolic-link
        if [[ "$(stat -c %h -- "$FILE")" -gt 1 ]]; then
            echo "File has more than one name."
        else
            cp "${FILE}" "${FILE}_old"
        fi
        rm -f "${FILE}"
    fi
    ln -s "${DIR}/${FILE}"
done


echo Restart your terminal to apply changes