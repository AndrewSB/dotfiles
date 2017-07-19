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

# aliases
alias make="CDPATH="" /usr/bin/make $@" #override the CDPATH while `make`ing. It sometimes causes [issues](https://github.com/thoughtbot/capybara-webkit/issues/56)
alias arc-upstream="~/Developer/arcanist/bin/arc"
alias e="scmpuff expand"
alias fuckwifi="networksetup -serairportpower airport off; networksetup -setairportpower airport on"

# utilities
eval "$(scmpuff init -s)"

# source a .secrets file, if it exists, that stores things I can't store on github
[[ -f ~/.secrets ]] && source ~/.secrets

# source a devserver secrets file that isn't checked in
if [[ -e ~/.devserver_secrets ]]; then
  source ~/.devserver_secrets
fi
