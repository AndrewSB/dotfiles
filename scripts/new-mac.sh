#!/bin/bash

# runnable as `curl -L andrew.energy/newmac | bash`

pushd ~
mkdir Developer
# TODO: nice to have, don't do this if not necessary
xcode-select --install

set -e

pushd ~/Developer
git clone git@github.com:AndrewSB/dotfiles.git
pushd dotfiles

yes n | ./scripts/setup-macos.sh
./scripts/copy-macos
source scripts/machine-setup-functions.sh
can_i_brew

set +e

brew_dependencies=("trash" "scmpuff" "neovim" "swiftlint" "MisterTea/et/et" "git-absorb" "go" "watchman" "mas" "gh")
cask_dependencies=("tripmode" "visual-studio-code" "protonvpn" "vlc" "github" "tandem" "slack" "google-chrome")
yes n | can_i_brew_deps
can_i_cask_deps

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# TODO: this didn't work for some reason, debug next time
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install stable
nvm alias default stable

echo "about to download Xcode, everything else is done. this is going to take a while"
mas_dependencies=(
	"1284863847" # Unsplash Wallpapers
	"1514817810" # Poolside FM
	"497799835" # Xcode
)
mas install "${mas_dependencies[@]}"

# aka popd --all (https://unix.stackexchange.com/a/353361)
pushd -0 && dirs -c
