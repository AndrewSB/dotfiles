# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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

## load custom executable functions {{
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
#
# Set TMPDIR if the variable is not set/empty or the directory doesn't exist
if [[ -z "${TMPDIR}" ]]; then
  export TMPDIR="/tmp/zsh-${UID}"
fi

if [[ ! -d "${TMPDIR}" ]]; then
  mkdir -m 700 "${TMPDIR}"
fi
 
# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=150000
SAVEHIST=150000

# Enable extended globbing
setopt extendedglob

# Disable correction of incorrect commands
unsetopt CORRECT

# <C-s> fix: http://stackoverflow.com/questions/8616843/ctrl-s-is-not-working-as-a-horizontal-split-in-vim-when-using-commandt
stty -ixon -ixoff

# If you use zsh in vi mode, add this to ensure ^R still does what we expect: https://fburl.com/cmdline-efficiency
bindkey "^R" history-incremental-search-backward

zle -N accept-line auto_ls
zle -N other-widget auto_ls

## setUpThatPrompt {
# archey it up 🔥  prompt
archey

setopt PROMPT_SUBST
local wave_or_explode='%(?:%{$fg_bold[green]%}👋:%{$fg_bold[red]%}💥)'
PROMPT="${wave_or_explode}%{$reset_color%}  "

local git_or_cwd_info='$(~/.zsh/functions/git-info-or-cwd/exec)'
RPROMPT="${git_or_cwd_info}%{$reset_color%}"
## }
