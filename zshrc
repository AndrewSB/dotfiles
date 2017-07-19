export ZSH=~/.oh-my-zsh

plugins=(git github xcode)

source $ZSH/oh-my-zsh.sh # execute on the theme and plugins #ALLTHEZSH

# Expose all the directories inside `Developer/` for cding when your in ~
export CDPATH=Developer/


## load custom executable functions {{

# first bootstrap by including include 😋
source ~/.zsh/functions/include

# the include all the .zsh/functions
for function in ~/.zsh/functions/*; do
    include $function
done
# }}

## language specific {{

# For when I'm golanging
export GOPATH=~/go
include '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
include '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
export PATH="$GOPATH/bin:$PATH"

# for when I'm rvming
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# for when I'm reacting
export REACT_EDITOR=atom
## }}

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

# Enable extended globbing
setopt extendedglob

# <C-s> fix: http://stackoverflow.com/questions/8616843/ctrl-s-is-not-working-as-a-horizontal-split-in-vim-when-using-commandt
stty -ixon -ixoff

# aliases
alias rm="trash" # lets never actually rm, that scares me. To actually rm, run `\rm`
alias synx="synx --no-sort-by-name"
alias b="brew"
alias networkpopup="open /System/Library/CoreServices/Captive\ Network\ Assistant.app"
alias devser="mosh -6 fb"
alias make="CDPATH="" /usr/bin/make $@" #override the CDPATH while `make`ing. It sometimes causes [issues](https://github.com/thoughtbot/capybara-webkit/issues/56)

## setUpThatPrompt {
# archey it up 🔥  prompt
archey

local wave_or_explode="%(?:%{$fg_bold[green]%}👋:%{$fg_bold[red]%}💥)"
PROMPT="${wave_or_explode}%{$reset_color%}  "

local git_or_cwd_info='$(~/.zsh/functions/git-info-or-cwd/exec)'
RPROMPT="${git_or_cwd_info}%{$reset_color%}"
## }
