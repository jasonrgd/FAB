#!/usr/bin/env bash

#disallow direct access
set -e
trap '>&2 printf "\n\e[01;31mERROR\033[0m: Command \`%s\` on line $LINENO failed with exit code $?\n" "$BASH_COMMAND"' ERR

fab_install_package()
{
    declare OS="$(uname -s)"

    if [ "${OS}" == "Darwin" ]; then
        brew install -y $@
    elif [ "${OS}" == "Linux" ]; then
        if [ -f /etc/debian_version ]; then
            sudo apt-get install -y $@
        fi
    fi
}