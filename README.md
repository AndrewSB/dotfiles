# dotfiles

These are the dotfiles I use on macOS. When used _correctly_, it should look
something like

![shell gif](https://media.giphy.com/media/pyAYkeVFs0A2pzSaL6/giphy.gif)

`scripts/pihole-install.sh` installs pihole in a local Docker container and sets
the machine's DNS server to that container's process

`scripts/setup-macos.sh` is inspired from https://mths.be/macos to set macOS
system preferences to settings I enjoy

`scripts/ensure_machine_setup.sh` sets up a new macOS machine by installing
things like Xcode, Homebrew, rvm, and some {brew, brew cask}s

# `scripts/setup-macos.sh` TODO: 
2. Hide menubar
2. Enable zoom
2. Enable iMessage iCloud Sync
