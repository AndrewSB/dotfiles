#!/bin/bash

# runnable as `curl -L andrew.energy/newmac | bash`

#
# Current workflow
# - create ssh key, upload to gh
# - add ssh key to keychain
# run script 
# clone a bunch of repositories (might be nice to have a Working.bundle that can clone automatically
# most painful: sign into all services

pushd ~
mkdir Developer

xcode-select --install
sudo xcodebuild -license accept

pushd ~/Developer
git clone git://github.com/AndrewSB/dotfiles.git
pushd dotfiles

set -e

yes n | ./scripts/setup-macos.sh
./scripts/copy-macos
# shellcheck source=./machine-setup-functions.sh
source scripts/machine-setup-functions.sh
can_i_brew

set +e

source ~/.profile # so the newly installed brew comes into scope
brew bundle


if [ ! -f $HOME/.ssh/id_rsa ]; then;
	ssh-keygen -t rsa -b 4096 -C "asbreckenridge@me.com"
	ssh-add --apple-use-keychain ~/.ssh/id_rsa
fi

gh auth login

# aka popd --all (https://unix.stackexchange.com/a/353361)
pushd -0 && dirs -c
