#!/usr/bin/env bash

# https://medium.com/@ssmak/how-to-fix-puppetteer-error-while-loading-shared-libraries-libx11-xcb-so-1-c1918b75acc3
CHROME_DEPS=( "xdg-utils" "wget" "lsb-release" "libxtst6" "libxss1" "libxrender1" "libxrandr2" "libxi6" "libxfixes3" "libxext6" "libxdamage1" "libxcursor1" "libxcomposite1" "libxcb1" "libx11-xcb1" "libx11-6" "libstdc++6" "libpangocairo-1.0-0" "libpango-1.0-0" "libnss3" "libnspr4" "libgtk-3-0" "libglib2.0-0" "libgdk-pixbuf2.0-0" "libgconf-2-4" "libgcc1" "libgbm1" "libfontconfig1" "libexpat1" "libdbus-1-3" "libcups2" "libcairo2" "libc6" "libatk1.0-0" "libatk-bridge2.0-0" "libasound2" "libappindicator1" "gconf-service" "fonts-liberation" "ca-certificates" )

PACKAGES=( "mosh" "zsh" "neovim" )

sudo apt-get update
sudo apt-get install --yes "${CHROME_DEPS[@]}" "${PACKAGES[@]}"

# switch to zsh
sudo chsh -s /usr/bin/zsh asb

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# install scmpuff
pushd "$(mktemp -d)"
curl -L https://github.com/mroth/scmpuff/releases/download/v0.3.0/scmpuff_0.3.0_linux_x64.tar.gz | tar xvz
sudo mv scmpuff /usr/local/bin/
popd

# install et
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:jgmath2000/et
sudo apt-get update
sudo apt-get install -y et
