#!/bin/bash
#
# This script ensures that a machine is setup for my usual development work.
# It
# 	1. makes sure you have XCode's command line tools
# 	2. Gets homebrew and installs
ios_brew_dependencies=("swiftgen" "swiftlint" "carthage")
brew_dependencies=("trash" "hub" "node" "scmpuff" "neovim")
cask_dependencies=("docker" "tripmode" "figmadaemon" "visual-studio-code")
# 	3. installs zim
#	4. makes sure you have ruby greater than
min_ruby_version=2.3
#	   and installs ruby through rvm for you if you have a lower version
#	5. installs some dependencies through gem
gem_dependencies=()

source ./machine-setup-functions.sh

can_i_xcode
can_i_brew
can_i_brew_deps
can_i_cask_deps
can_i_ruby
if [ ! ${#gem_dependencies[@]} -eq 0 ]; then # skip installing gems if empty
    can_i_gem
fi


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
