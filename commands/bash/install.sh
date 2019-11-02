#!/usr/bin/env bash

#disallow direct access
set -e
trap '>&2 printf "\n\e[01;31mERROR\033[0m: Command \`%s\` on line $LINENO failed with exit code $?\n" "$BASH_COMMAND"' ERR

#install as a global command and add ./bin to user/system path

#check to see if configuration manager can be installed

python_installed="false"
pip_installed="false"

## check to see if python is installed or not
if [ command -v python3 &>/dev/null ]; then
    echo "py"
    python_installed="true"
fi
if  [ command -v pip3 &>/dev/null ]; then
    echo "pip"
    pip_installed="true"
fi

echo ${python_installed}, ${pip_installed}
if [[ pip_installed == "false"  || python_installed == "false" ]]; then
    echo "je;"
    fab_install_package python3 python3-pip
fi

#install configuration manager
#python3 -m pip install ansible

#install all dependencies to make this work by running the playbook