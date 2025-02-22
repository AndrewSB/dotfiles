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
# Dev tools
#

[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# load custom executable functions and aliases {{
source $HOME/.zsh/functions/include # first bootstrap by including include 😋

# the include all the .zsh/functions
for function in $HOME/.zsh/functions/*; do
    include $function
done

source $HOME/.zsh/functions/_load_nvm

source $HOME/.git.alias
# }}

if [[ ! -d "${TMPDIR}" ]]; then
  mkdir -m 700 "${TMPDIR}"
fi

#
# History Settings
#
setopt sharehistory
HISTFILE=$HOME/.zhistory
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

#
# Completions
#
# Copied from https://docs.brew.sh/Shell-Completion ...
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# bun completions
[ -s "/Users/asb/.bun/_bun" ] && source "/Users/asb/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Created by `pipx` on 2024-06-03 04:15:09
export PATH="$PATH:/Users/asb/.local/bin"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
