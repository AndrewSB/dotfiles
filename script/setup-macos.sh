#!/usr/bin/env bash

# Adapted from https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh and https://mths.be/macos

# Ask for the administrator password upfront
sudo -v

# Exit early on an error
set -e
ZOOM_SETTINGS_FAILED=false

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
COMPUTER_NAME="asb-mbp"
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME" 

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic capitalization as it’s the way of the future
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# System Preferences > General > Appearance
defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Accessibility > Zoom: use a scroll gesture with the Control modifier to zoom.
# macOS requires the terminal running this script to have Full Disk Access before
# it can change the protected com.apple.universalaccess preference domain.
if ! defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true || \
	! defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144; then
	ZOOM_SETTINGS_FAILED=true
fi

# Move a window by holding Control + Command and dragging anywhere within it.
# Running applications must be relaunched before they recognize this setting.
defaults write NSGlobalDomain NSWindowShouldDragOnGesture -bool true

# System Preferences > Trackpad > Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# System Preferences > Dock > Size:
defaults write com.apple.dock tilesize -int 100

# System Preferences > Dock > Magnification:
defaults write com.apple.dock magnification -bool false

# System Preferences > Dock > Minimize windows using: Genie effect
defaults write com.apple.dock mineffect -string "genie"

# System Preferences > Dock > Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# System Preferences > Dock > Automatically hide and show the Dock (duration)
defaults write com.apple.dock autohide-time-modifier -float 0.5

# System Preferences > Dock > Automatically hide and show the Dock (delay)
defaults write com.apple.dock autohide-delay -float 0.1

# System Preferences > Dock > Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Don't group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false

# System Preferences > Mission Control > Automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Activity Monitor > View > Update Frequency
defaults write com.apple.ActivityMonitor UpdatePeriod -int 1

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Terminal                                                                    #
###############################################################################

# Set default window as Large Font.terminal
DIRNAME=$(dirname "$0")
open "$DIRNAME"/../Large\ Font.terminal
defaults write com.apple.terminal "Default Window Settings" "Large Font"
defaults write com.apple.terminal "Startup Window Settings" "Large Font"

echo "Done. Relaunch affected applications or log out for all changes to take effect."

if [ "$ZOOM_SETTINGS_FAILED" == true ]; then
	echo "Zoom was not changed because this terminal does not have Full Disk Access."
	echo "Grant it in System Settings > Privacy & Security > Full Disk Access, then rerun this script."
fi
