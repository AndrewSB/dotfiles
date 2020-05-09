#!/usr/bin/env bash

# https://medium.com/@ssmak/how-to-fix-puppetteer-error-while-loading-shared-libraries-libx11-xcb-so-1-c1918b75acc3
CHROME_DEPS=( "gconf-service" "libasound2" "libatk1.0-0" "libatk-bridge2.0-0" "libc6" "libcairo2" "libcups2" "libdbus-1-3" "libexpat1" "libfontconfig1" "libgcc1" "libgconf-2-4" "libgdk-pixbuf2.0-0" "libglib2.0-0" "libgtk-3-0" "libnspr4" "libpango-1.0-0" "libpangocairo-1.0-0" "libstdc++6" "libx11-6" "libx11-xcb1" "libxcb1" "libxcomposite1" "libxcursor1" "libxdamage1" "libxext6" "libxfixes3" "libxi6" "libxrandr2" "libxrender1" "libxss1" "libxtst6" "ca-certificates" "fonts-liberation" "libappindicator1" "libnss3" "lsb-release" "xdg-utils" "wget" )

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
