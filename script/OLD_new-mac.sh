#!/bin/bash

# retired on 2023-01-25 in favor of using mackup more

# runnable as `curl -L andrew.energy/newmac | bash`

# Current workflow
# run script
# clone a bunch of repositories (might be nice to have a Working.bundle that can clone automatically
# most painful: sign into all services in Safari with 2FAC

if [ ! -e ~/.ssh/id_ed25519 ]; then
    echo "Please generate a SSH key before running this. you should run the following command:"
    echo "ssh-keygen -t ed25519 -C \"asbreckenridge@me.com\""
    exit 1
fi

sudo echo
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install gh
gh auth login --git-protocol ssh --web -s admin:public_key
ssh-add --apple-use-keychain

echo "What would you like to name this key on github?"
read -r KEY_NAME
gh ssh-key add ~/.ssh/id_ed25519.pub -t "$(date +%Y-%m-%d) $KEY_NAME"

pushd ~
mkdir Developer
pushd ~/Developer

gh repo clone AndrewSB/dotfiles
pushd dotfiles

set -e

yes n | ./script/setup-macos.sh
./script/copy-macos

set +e

brew bundle

# aka popd --all (https://unix.stackexchange.com/a/353361)
pushd -0 && dirs -c
