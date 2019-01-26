#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Andrew's customization
#

# Utility to safely source a path that doesn't error if the file doesnt exist
source $HOME/.bash_functions/include 
# then include all the .bash_functions
for function in ~/.bash_functions/*; do
    include $function
done

# aliases
alias rm="trash" # lets never actually rm, that scares me. To actually rm, run `\rm`
alias xc="open *.{xcworkspace,xcodeproj}(N)"
alias synx="synx --no-sort-by-name"
alias b="brew"
alias networkpopup="open /System/Library/CoreServices/Captive\ Network\ Assistant.app"
alias make="CDPATH="" /usr/bin/make $@" #override the CDPATH while `make`ing. It sometimes causes [issues](https://github.com/thoughtbot/capybara-webkit/issues/56)
alias arc-upstream="~/Developer/arcanist/bin/arc"
alias e="scmpuff expand"
alias fuckwifi="networksetup -serairportpower airport off; networksetup -setairportpower airport on"

# git aliases
source $HOME/.git.alias

# utilities
eval "$(scmpuff init -s)"

# source a .secrets file, if it exists, that stores things I can't store on github
[[ -f ~/.secrets ]] && source ~/.secrets
