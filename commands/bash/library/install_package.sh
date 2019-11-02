#!/usr/bin/env bash

#disallow direct access
set -e
trap '>&2 printf "\n\e[01;31mERROR\033[0m: Command \`%s\` on line $LINENO failed with exit code $?\n" "$BASH_COMMAND"' ERR

fab_install_package()
{
    declare OS="$(uname -s)"
    declare check_installed=`command -v $1`
    if [[ ${check_installed} ]]; then
        install=false
    else
        echo "installing $2"
        install=true 
    fi

    if [[ ${install} == true ]]; then
        if [ "${OS}" == "Darwin" ]; then
            brew install -y $2
        elif [ "${OS}" == "Linux" ]; then
            if [ -f /etc/debian_version ]; then
                sudo apt-get install -y $2
            fi
        fi
    fi
}