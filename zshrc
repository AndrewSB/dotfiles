# Path to your oh-my-zsh installation.
export ZSH=/Users/asb/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
export CDPATH=Developer/

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/Users/asb/Library/Developer/go_appengine:$PATH"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

export GOPATH="/Users/asb/godev"
export REACT_EDITOR=atom

source $ZSH/oh-my-zsh.sh

# Custom cursor
# PROMPT="🔥  %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# load custom executable functions
for function in ~/.zsh/functions/*; do
    source $function
done

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
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

# vi mode
# bindkey -v
# bindkey "^F" vi-cmd-mode
# bindkey jj vi-cmd-mode

# <C-s> fix: http://stackoverflow.com/questions/8616843/ctrl-s-is-not-working-as-a-horizontal-split-in-vim-when-using-commandt
stty -ixon -ixoff

# support for Carthage completion https://github.com/Carthage/Carthage/blob/master/Documentation/BashZshCompletion.md
autoload -U compinit
compinit -u

# aliases
alias showall="defaults write com.apple.finder AppleShowAllFiles TRUE"
alias hideall="defaults write com.apple.finder AppleShowAllFiles FALSE"
alias rm="trash"
alias synx="synx --no-sort-by-name"
alias gpall="git remote | xargs -L1 git push --all"
alias dev="cd ~/Developer"
alias bci="brew cask install "
