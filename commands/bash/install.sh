#!/usr/bin/env bash

#disallow direct access
set -e
trap '>&2 printf "\n\e[01;31mERROR\033[0m: Command \`%s\` on line $LINENO failed with exit code $?\n" "$BASH_COMMAND"' ERR

if [ -z "$1" ]; then
    #check for windows
    declare OS=$1
else
    declare OS="$(uname -s)"
fi
declare OS="$(uname -s)"

#install as a global command and add ./bin to user/system path


#check to see if configuration manager can be installed
fab_install_package python3 python3
fab_install_package pip3 python3-pip


#convert to ansible task
if [ "${OS}" == "Darwin" ]; then
    curl -Lo "${FAB_DIR}/bin/minikube" https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
elif [ "${OS}" == "Linux" ]; then
    curl -Lo "${FAB_DIR}/bin/minikube" https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64
fi

chmod +x "${FAB_DIR}/bin/minikube"

if [ "${OS}" == "Darwin" ]; then
    curl -Lo "${FAB_DIR}/bin/kubectl" "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
elif [ "${OS}" == "Linux" ]; then
    curl -Lo "${FAB_DIR}/bin/kubectl" https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
fi

chmod +x "${FAB_DIR}/bin/kubectl"

python=python3

python3 -m venv env
source env/bin/activate

#install all requirements
$python -m pip install -r requirements.txt

#install all dependencies to make this work by running the playbook
