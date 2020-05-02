# Functions for ensure-machine-setup
# `source` this file

# http://stackoverflow.com/a/17841619
function join_by { local IFS="$1"; shift; echo "$*"; }

function fire_echo { echo "🔥" $@; }

function can_i_xcode() {
	xcode-select -p >&/dev/null # this checks if xcode command line tools are installed (http://stackoverflow.com/a/15371967)
	if [ $? -eq 0 ]; then
		# if xcode-select exited with 0, then you have command line tools
		if [ ! -d "/Applications/Xcode.app" ]; then
			fire_echo "It looks like you have Xcode's command line tools installed, but no XCode"
			fire_echo "You might want to get Xcode from the Mac App Store"
		else
			fire_echo "You have Xcode 🎉"
		fi
	else
		fire_echo "It looks as though you don't have XCode command line tools."
		fire_echo "You can either download & open Xcode, or run xcode-select --install"
		fire_echo "Try running this again after you've done that."
		exit 1
	fi
}

function can_i_oh_my_zsh() {
	set -e
		if ! [ -d ~/.oh-my-zsh ]; then
			fire_echo "You don't have oh-my-zsh, let's install it"
			sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		fi
		fire_echo "oh my zsh is installed 🎉"
	set +e
}

function can_i_zim() {
	set -e
		if ! [ -d "${ZDOTDIR:-$HOME}/.zim" ]; then
			git clone --recursive https://github.com/Eriner/zim.git ${ZDOTDIR:-${HOME}}/.zim
		fi
		fire_echo "zim is installed 🎉"
		fire_echo "WARNING: make sure you change your shell to zsh (you can chsh -s /bin/zsh)"
	set +e
}

function can_i_brew() {
	set -e
	if ! which brew >/dev/null; then
		fire_echo "You don't have homebrew, we're going to install it for you"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	set +e
}

function can_i_brew_deps() {
	fire_echo "You have brew, we're going to install some packages"
	read -p "Would you like to also install iOS packages (`join_by , "${ios_brew_dependencies[@]}"`) (y/n)? " answer
	case ${answer:0:1} in
		y|Y )
			BREW_INSTALLS=("${brew_dependencies[@]}" "${ios_brew_dependencies[@]}")
		;;
		* )
			BREW_INSTALLS=("${brew_dependencies[@]}")
		;;
	esac
	fire_echo "Installing `join_by , "${BREW_INSTALLS[@]}"`."
	set -e; /usr/local/bin/brew install ${BREW_INSTALLS[@]}; set +e;

	fire_echo "Would you like to own the zsh/completion directory so compinit doesn't complain?"
	read -p "(y/n) "
	case ${answer:0:1} in
		y|Y )
			sudo chmod -R go-w /usr/local/share
		;;
		*)
			fire_echo "alright, not owning. Moving on..."
		;;
}

function can_i_cask_deps() {
	fire_echo "Going to install brew casks now: `join_by , "${cask_dependencies[@]}"`"
	set -e
	/usr/local/bin/brew cask install ${cask_dependencies[*]}
	set +e;
}

function can_i_ruby() {
	set -e
	if ! [[ `ruby -v | awk '{print $2}'` > "${min_ruby_version}" ]]; then
		fire_echo "You have an outdated version of ruby (`ruby -v`) (if you're seeing this repeatedly, check your $PATH, it's possible that your ordering is incorrect)"
		if ! which rvm >/dev/null; then
			fire_echo "Installing rvm to update ruby for you"

			curl -L https://get.rvm.io | bash -s stable
		fi

		fire_echo "Installing latest ruby through rvm"
		source "$HOME/.profile" # rvm writes to ~/.profile, sourcing the file lets us use rvm without reloading the shell session
		`rvm use ruby --install --default` # currently stuck on this line. Output looks like http://imgur.com/w9Iq1Yq
	fi
	set +e
}

function can_i_gem() {
	fire_echo "You have the latest ruby, so we're going to install some gems"
	for dependency in "${gem_dependencies[$@]}"; do
		if ! which "${dependency}" >/dev/null; then
			fire_echo "Downloading ${dependency}"
			set -e; gem install ${dependency}; set +e
		fi
	done
}
