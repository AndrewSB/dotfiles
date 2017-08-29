#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='vim'
export VISUAL='vim'
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

# makes color constants available so we can...
autoload -U colors
colors

# ... enable colored output from ls, etc
export CLICOLOR=1

# aliases
alias rm="trash" # lets never actually rm, that scares me. To actually rm, run `\rm`
alias xc="open *.{xcworkspace,xcodeproj}(N)"
alias synx="synx --no-sort-by-name"
alias b="brew"
alias networkpopup="open /System/Library/CoreServices/Captive\ Network\ Assistant.app"
alias server="et -c=\"tmux -CC a || tmux -CC new\" our.asb.sb.facebook.com:8080"
alias make="CDPATH="" /usr/bin/make $@" #override the CDPATH while `make`ing. It sometimes causes [issues](https://github.com/thoughtbot/capybara-webkit/issues/56)
