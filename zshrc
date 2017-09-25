#
# Zim
#

# Change default zim location 
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Source zim
if [[ -s ${ZIM_HOME}/init.zsh ]]; then
  source ${ZIM_HOME}/init.zsh
fi

# Source facebook things
[[ -z "$LOCAL_ADMIN_SCRIPTS" ]] && export LOCAL_ADMIN_SCRIPTS='/usr/facebook/ops/rc'
source "${LOCAL_ADMIN_SCRIPTS}/master.zshrc"

#
# Job control
#

# Enables bash like `fg %n`ing https://stackoverflow.com/a/32614814
fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
cdpath=(
  ~/Developer/
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  ~/.zsh/functions
  /usr/local/{bin,sbin}
  $path
)

## load custom executable functions and aliases {{
source ~/.zsh/functions/include # first bootstrap by including include 😋

# the include all the .zsh/functions
for function in ~/.zsh/functions/*; do
    include $function
done

source ~/.git.alias
# }}

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

if [[ ! -d "${TMPDIR}" ]]; then
  mkdir -m 700 "${TMPDIR}"
fi

# makes color constants available so we can...
autoload -U colors
colors

# ... enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=9999999
SAVEHIST=9999999
setopt appendhistory

# Enable extended globbing
setopt extendedglob

# Disable correction of incorrect commands
unsetopt CORRECT

# <C-s> fix: http://stackoverflow.com/questions/8616843/ctrl-s-is-not-working-as-a-horizontal-split-in-vim-when-using-commandt
stty -ixon -ixoff

# enables vi mode
set -o vi

# If you use zsh in vi mode, add this to ensure ^R still does what we expect: https://fburl.com/cmdline-efficiency
bindkey "^R" history-incremental-search-backward

# Use the current line as a search term on up/down keystrokes. To access previous command \^[[A on an empty line. This is so complicated to work around vi mode. Copied from https://github.com/robbyrussell/oh-my-zsh/issues/1720
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# makes color constants available so we can...
autoload -U colors
colors

# ... enable colored output from ls, etc
export CLICOLOR=1

# Theme it up 
source ~/.zim/modules/prompt/themes/wave.zsh-theme
