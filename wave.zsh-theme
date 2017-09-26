#
# A 🔥 y theme @AndrewSB enjoys
#
# Authors:
#	Andrew Breckenridge (🔥 ) <asb@fb.com>
#
# Features:
#	- R A D I C A L L Y  simple left prompt - either 👋  or 💥  based on the return code
#	- the version in the fb branch has super optimized mercurial & git support
#
# Requires the `git-info` zmodule to be included in the .zimrc file.

function _machine_and_cwd() {
	case `uname -n` in
		"asb-mbp")
			local machine="💻"
			;;

		*"devvm"*)
			local machine="🖥"
			;;

		*)
			local machine="🤔"
			;;
	esac

	print -n "%~$machine"
}

function wave_git_info() {
	local git_output=`command git rev-parse --abbrev-ref HEAD || echo ""` 
	if ! [[ -z $git_output ]]; then
		printf '(%s) ' $git_output
	fi
}

function prompt_wave_precmd {
}

function prompt_wave_setup {
	autoload -Uz add-zsh-hook # Loads required functions

	add-zsh-hook precmd prompt_wave_precmd # Adds hook for calling prompt_waveprecmd before each command

	# auto ls on empty line
	zle -N accept-line auto_ls
	zle -N other-widget auto_ls

	local wave_or_explode="%(?:%{$fg_bold[green]%}👋:%{$fg_bold[red]%}💥)"
	SPACES_AFTER_EMOJI=" "

	# Define prompts
	setopt PROMPT_SUBST
	PROMPT="${wave_or_explode}%{$reset_color%}${SPACES_AFTER_EMOJI}"
	RPROMPT='$(wave_git_info)$(_machine_and_cwd)${SPACES_AFTER_EMOJI}'
}

prompt_wave_setup "$@"
