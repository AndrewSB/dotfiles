#
# Bashrc
#

source $HOME/.profile # surprisingly, bash doesnt source the profile

#
# Helpers
#

# Array -> delimited string
function join_by { local IFS="$1"; shift; echo "$*"; } 


#
# PATH and external functions
#

# Set the list of directories that bash searches for programs
newpath=(
  $HOME/.cargo/bin
  $HOME/.fastlane/bin
  /usr/local/{bin,sbin}
  $PATH
)
PATH=$(join_by ':' ${newpath[@]})

#
# Completion
#
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
	. /opt/facebook/share/bash_completion
fi

#
# History
#

# Set the history limit to "disk size (and your "largest file limit", if your OS or FS has one)"
export HISTSIZE=
export HISTFILESIZE=

# Behavior so the history file is appended to instead of being overwritten
shopt -s histappend

# https://unix.stackexchange.com/a/48116 {{
# Allows history sharing between active sessions
_bash_history_sync() {
  builtin history -a
  HISTFILESIZE=$HISTSIZE
  builtin history -c
  builtin history -r
}

history() {                  
  _bash_history_sync
  builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync
# }}

PS1="👋 "
