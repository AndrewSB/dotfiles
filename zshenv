# from https://unix.stackexchange.com/a/71258, $PATH, $EDITOR, and $PAGER are often set in .zshenv

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
# Misc
#

export XDG_CONFIG_HOME="$HOME/.config"

#
# PATHs
#

export GOPATH=$HOME/Developer/go
export PIP_INSTALL_PATH=$HOME/Library/Python/3.9/bin

# Set the the list of directories that cd searches.
cdpath=(
  ~/Developer/
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/.cargo/bin
  $HOME/Library/Android/sdk/tools
  $HOME/Library/Android/sdk/platform-tools
  ~/.zsh/functions
  /usr/local/{bin,sbin}
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/ # for `airport`
  $PIP_INSTALL_PATH
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

# Set TMPDIR if the variable is not set/empty or the directory doesn't exist
if [[ -z "${TMPDIR}" ]]; then
  export TMPDIR="/tmp/zsh-${UID}"
fi
