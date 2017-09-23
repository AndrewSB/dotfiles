#
# A 🔥 y theme cho boy @AndrewSB enjoys
#
# Authors:
#	Andrew Breckenridge (🔥 ) <asb@fb.com>
#
# Features:
#	- Radically simple left prompt - either 👋  or 💥  based on the return code
#	- shows the current directory and some git information using a 🔥 y Swift binary, written by yours truly
#	- the version in the fb branch has super optimized mercurial support
#

function prompt_waveprecmd {
}

function prompt_wavesetup {
	autoload -Uz add-zsh-hook # Loads required functions

	add-zsh-hook precmd prompt_waveprecmd # Adds hook for calling prompt_waveprecmd before each command
	setopt PROMPT_SUBST

	# auto ls on empty line
	zle -N accept-line auto_ls
	zle -N other-widget auto_ls

	local wave_or_explode="%(?:%{$fg_bold[green]%}👋:%{$fg_bold[red]%}💥)"
	local git_or_cwd_info="$(~/.zsh/functions/git-info-or-cwd/exec)"
	# Define prompts
	PROMPT="${wave_or_explode}%{$reset_color%}  "
	RPROMPT="${git_or_cwd_info}%{$reset_color%}"
}

prompt_wavesetup "$@"
