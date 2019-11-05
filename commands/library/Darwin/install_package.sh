#!/usr/bin/env bash

#disallow direct access
set -e
trap '>&2 printf "\n\e[01;31mERROR\033[0m: Command \`%s\` on line $LINENO failed with exit code $?\n" "$BASH_COMMAND"' ERR

fab_install_package()
{
    declare check_installed=`command -v $1`
    if [[ ${check_installed} ]]; then
        install=false
    else
        echo "installing $2"
        install=true 
    fi

    if [[ ${install} == true ]]; then
            #add a check for cask else do a brew install
            if [ -z "$3" ]; then
                brew install -y $2
            else 
                brew install -y $3
            fi
    fi
}