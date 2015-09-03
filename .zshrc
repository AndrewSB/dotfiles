# Path to your oh-my-zsh installation.
export ZSH=/Users/asb/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export CDPATH=Developer/
export CDPATH=$CDPATH:Developer/gocode/src/github.com/AndrewSB/

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/Users/asb/Library/Developer/go_appengine:$PATH"

export GOPATH="/Users/asb/Developer/gocode"

source $ZSH/oh-my-zsh.sh

# load custom executable functions
for function in ~/.zsh/functions/*; do
    source $function
done

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias showall="defaults write com.apple.finder AppleShowAllFiles TRUE"
alias hideall="defaults write com.apple.finder AppleShowAllFiles FALSE"


fortune | cowsay -f dragon | lolcat
