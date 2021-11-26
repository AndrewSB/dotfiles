#!/bin/bash

# runnable as `curl -L andrew.energy/newmac | bash`

pushd ~
mkdir Developer

xcode-select --install

# TODO: check for ~/.ssh/id_rsa, else run
# ssh-keygen -t rsa -b 16384 -C "asbreckenridge@me.com"

pushd ~/Developer
git clone git@github.com:AndrewSB/dotfiles.git
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

# aka popd --all (https://unix.stackexchange.com/a/353361)
pushd -0 && dirs -c
