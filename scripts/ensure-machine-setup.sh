#!/bin/bash
#
# This script ensures that a machine is setup for my usual development work.
# It
# 	1. makes sure you have Xcode's command line tools
# 	2. Gets homebrew and installs
ios_brew_dependencies=("swiftgen" "carthage") # optionally, asks in a prompt
brew_dependencies=("trash" "hub" "gh" "scmpuff" "neovim" "swiftlint" "MisterTea/et/et" "git-absorb")
cask_dependencies=("docker" "tripmode" "visual-studio-code" "alt-tab" "protonvpn" "vlc" "github")
# and installs nvm

DIRNAME=`dirname "$0"`

source $DIRNAME/machine-setup-functions.sh

can_i_xcode
can_i_brew
can_i_brew_deps
can_i_cask_deps
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash


echo ""
echo "All done 🎉"
echo "Don't forget to run ./copy to get the dotfiles, and ./setup-macos.sh (WHICH WILL KILLALL TERMINAL)."
read -p "Would you like to run them here? (y/n)" answer
case ${answer:0:1} in
  y|Y )
    set -e
    echo "running copy"
    ./copy
    echo "running setup-macos.sh, which will cause Terminal to quit"
    ./setup-macos.sh
    set +e
  ;;
  * )
    echo "alright, not running 🙃"
  ;;
esac
