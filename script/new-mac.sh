#!/bin/bash
# runnable as `curl -L andrew.energy/newmac | bash`

sudo echo

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"

# Install Mackup
brew install mackup

# creates ~/.mackup.cfg and writes the following to it:
# [storage]
# engine = icloud
rm ~/.mackup.cfg
echo "[storage]" > "$HOME/.mackup.cfg"
echo "engine = icloud" >> "$HOME/.mackup.cfg"

mackup restore -f

brew install gh

mkdir Developer
pushd ~/Developer || exit

gh repo clone AndrewSB/dotfiles
pushd dotfiles || exit

set -e

brew bundle

popd || exit

xcodes install --latest
