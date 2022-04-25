#!/bin/bash
# runnable as `curl -L andrew.energy/newmac | bash`

# Current workflow
# run script
# clone a bunch of repositories (might be nice to have a Working.bundle that can clone automatically
# most painful: sign into all services in Safari with 2FAC

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install gh
gh auth login --git-protocol ssh --web
ssh-add --apple-use-keychain

pushd ~
mkdir Developer
pushd ~/Developer

gh repo clone AndrewSB/dotfiles
pushd dotfiles

set -e

yes n | ./scripts/setup-macos.sh
./scripts/copy-macos

set +e

brew bundle

# aka popd --all (https://unix.stackexchange.com/a/353361)
pushd -0 && dirs -c
