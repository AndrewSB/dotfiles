# aliases
alias make="CDPATH="" /usr/bin/make $@" #override the CDPATH while `make`ing. It sometimes causes [issues](https://github.com/thoughtbot/capybara-webkit/issues/56)
alias e="scmpuff expand"

# utilities
eval "$(scmpuff init -s)"

# source a .secrets file, if it exists, that stores things I can't store on github
[[ -f $HOME/.secrets ]] && source $HOME/.secrets

# source any platform specific profiles
for PLATFORM_PROFILE in ".profile.macos" ".profile.ubuntu"; do
  [[ -f ~/$PLATFORM_PROFILE ]] && source ~/$PLATFORM_PROFILE
done
