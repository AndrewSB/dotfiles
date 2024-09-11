#!/bin/bash
# runnable as `curl -L andrew.energy/newmac | bash`

sudo echo

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"

# Install Mackup
brew install mackup

# creates ~/.mackup.cfg and writes the following to it:
# [storage]
# engine = icloud
rm "$HOME/.mackup.cfg"
echo "[storage]" > "$HOME/.mackup.cfg"
echo "engine = icloud" >> "$HOME/.mackup.cfg"

mackup restore -f

brew install gh

mkdir Developer
pushd ~/Developer || exit

gh repo clone AndrewSB/dotfiles
pushd dotfiles || exit

set -e

brew bundle

popd || exit

XCODES_USERNAME="asbreckenridge@me.com" xcodes install --latest-prerelease
xcodes select
latest_ios_runtime=$(xcodes runtimes | grep '^iOS' | tail -n 1 | awk '{print $0}')
xcodes runtimes install "$latest_ios_runtime"

# Optionally, run the following secret. generated with:
# openssl enc -aes-256-cbc -pbkdf2 -a -salt -pass pass:"your-password-here" <<EOF
# commands to run here
#EOF
encrypted_command="U2FsdGVkX1/XeI1H8iaFzwgpxx5m10mVeyROvjadO4z7oN+oNTD8e+ygACGRKuaH3J4Q7hCXctZWPpRM+kHbx6511VKwWeOC7cO/79xLAUpyPhOVEbJQTW27rdVicPAm0yggu11rvuG/LO2mNTne5sakoS3Rf1eISq/+PIxhXjTbqEIJWDuhaDTPnd7Q96TUAsQ/7H8X6sakqql0cRyRDeaAjk5yyVrJRe7p1QqDmns="
read -rsp "Enter the password to decrypt the command: " password
decrypted_command=$(echo "$encrypted_command" | openssl enc -aes-256-cbc -pbkdf2 -a -d -salt -pass pass:"$password" 2>/dev/null)

# Check if decryption was successful
if [ $? -ne 0 ]; then
  echo "Decryption failed."
  exit 1
fi

# Execute the decrypted command
eval "$decrypted_command"
