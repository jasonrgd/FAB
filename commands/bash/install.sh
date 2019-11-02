#!/usr/bin/env bash

#disallow direct access
set -e
trap '>&2 printf "\n\e[01;31mERROR\033[0m: Command \`%s\` on line $LINENO failed with exit code $?\n" "$BASH_COMMAND"' ERR

#install as a global command and add ./bin to user/system path

#check to see if configuration manager can be installed
fab_install_package python3 python3
fab_install_package pip3 python3-pip

#install configuration manager
#python3 -m pip install ansible

#install all dependencies to make this work by running the playbook