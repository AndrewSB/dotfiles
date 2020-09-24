#!/bin/bash

# runnable as `curl andrew.energy/newmac | bash`

pushd ~
mkdir Developer
xcode-select --install

pushd ~/Developer
git clone git@github.com:AndrewSB/dotfiles.git
pushd dotfiles

yes n | ./scripts/setup-macos.sh
./scripts/copy-macos
can_i_brew

brew_dependencies=("trash" "gh" "scmpuff" "neovim" "swiftlint" "MisterTea/et/et" "git-absorb" "go" "watchman")
cask_dependencies=("docker" "tripmode" "visual-studio-code" "alt-tab" "protonvpn" "vlc" "github" "tandem")
yes n | can_i_brew_deps
can_i_cask_deps

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install stable
nvm alias default stable

# aka popd --all (https://unix.stackexchange.com/a/353361)
pushd -0 && dirs -c
