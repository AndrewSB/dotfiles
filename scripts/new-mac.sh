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

brew_dependencies=(
	"trash"
	"scmpuff" "git-absorb" "gh"
	"neovim"
	"swiftlint"
	"MisterTea/et/et"
	"go"
	"watchman"
	"mas")
cask_dependencies=(
	"visual-studio-code" "sketch"
	"protonvpn"
	"vlc" "spotify"
	"slack" "discord"
	"google-chrome"
	"lulu" "oversight")
yes | can_i_brew_deps "${brew_dependencies[@]}"
can_i_cask_deps "${cask_dependencies[@]}"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# TODO: this didn't work for some reason, debug next time
# shellcheck source=/dev/null
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
