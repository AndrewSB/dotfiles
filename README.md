# dotfiles

These are the dotfiles I use on macOS. When used _correctly_, it should look
something like

![shell gif](https://media.giphy.com/media/pyAYkeVFs0A2pzSaL6/giphy.gif)

`script/pihole-install.sh` installs pihole in a local Docker container and sets
the machine's DNS server to that container's process

`script/setup-macos.sh` is inspired from https://mths.be/macos to set macOS
system preferences to settings I enjoy

`script/bootstrap.sh` is for Github codespaces to setup itself (https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles)

`script/ensure_machine_setup.sh` sets up a new macOS machine by installing
things like Xcode, Homebrew, rvm, and some {brew, brew cask}s

# `script/setup-macos.sh` TODO:

2. Hide menubar
3. Enable zoom
4. turn off iCloud mail
