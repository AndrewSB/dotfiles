#!/bin/bash
#
# This script ensures that a machine is setup for usual development work.
# It 
# 	1. makes sure you have XCode's command line tools
# 	2. Gets homebrew and installs
brew_dependencies=("swiftgen" "swiftlint" "carthage" "trash" "hub" "node" "archey" "gpg" "scmpuff")
# 	3. installs oh-my-zsh
#	4. makes sure you have ruby greater than
min_ruby_version=2.3
#	   and installs ruby through rvm for you if you have a lower version
#	5. installs some dependencies through gem
gem_dependencies=()

source ./machine-setup-functions.sh

can_i_xcode
can_i_brew
can_i_brew_deps
can_i_zim
can_i_ruby
can_i_gem
echo "All done 🎉"
