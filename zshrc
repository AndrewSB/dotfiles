export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git github xcode)

source $ZSH/oh-my-zsh.sh # execute on the theme and plugins #ALLTHEZSH

# Useful include function that makes sure a path exists before sourcing it
include () { [[ -f "$1" ]] && source "$1" }

# Expose all the directories inside `Developer/` for cding when your in ~
export CDPATH=Developer/

# For when I'm golanging
export GOPATH=~/go
include '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
include '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export REACT_EDITOR=atom

# Custom cursor #addthe🔥
PROMPT="🔥  $PROMPT"

# load custom executable functions
for function in ~/.zsh/functions/*; do
    include $function
done

# makes color constants available so we can...
autoload -U colors
colors

# ... enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# badass cd movement a la zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# <C-s> fix: http://stackoverflow.com/questions/8616843/ctrl-s-is-not-working-as-a-horizontal-split-in-vim-when-using-commandt
stty -ixon -ixoff

# support for Carthage completion https://github.com/Carthage/Carthage/blob/master/Documentation/BashZshCompletion.md
autoload -U compinit
compinit -u

# aliases
alias showall="defaults write com.apple.finder AppleShowAllFiles TRUE"
alias hideall="defaults write com.apple.finder AppleShowAllFiles FALSE"
alias rm="trash" # lets never actually rm, that scares me. To actually rm, run `\rm`
alias synx="synx --no-sort-by-name"
alias gpall="git remote | xargs -L1 git push --all"
alias b="brew"
alias bc="brew cask"
alias networkpopup="open /System/Library/CoreServices/Captive\ Network\ Assistant.app"
