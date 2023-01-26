#!/bin/bash
# runnable as `curl -L andrew.energy/newmac | bash`

sudo echo
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install mackup

# creates ~/.mackup.cfg and writes the following to it:
# [storage]
# engine = icloud
touch ~/.mackup.cfg
echo "[storage]" >> ~/.mackup.cfg
echo "engine = icloud" >> ~/.mackup.cfg

# forces iCloud Drive to sync the Mackup folder

mackup restore -f