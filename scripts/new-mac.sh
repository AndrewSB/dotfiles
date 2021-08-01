#!/bin/bash

# runnable as `curl -L andrew.energy/newmac | bash`

pushd ~
mkdir Developer
# TODO: nice to have, don't do this if not necessary
xcode-select --install


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

brew bundle

# aka popd --all (https://unix.stackexchange.com/a/353361)
pushd -0 && dirs -c
