#
# A 🔥 y theme cho boy @AndrewSB enjoys
#
# Authors:
#	Andrew Breckenridge (🔥 ) <asb@fb.com>
#
# Features:
#	- Radically simple left prompt - either 👋  or 💥  based on the return code
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
	local git_output=`command git rev-parse --abbrev-ref HEAD 2>/dev/null || echo ""` 
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

	# Figure out how much padding we want for the emoji because glibc had an emoji rendering bug
	if ! [ -z ${ITERM_PROFILE+x} ]; then
		SPACES_AFTER_EMOJI="   "
	elif ! [ -z ${Apple_PubSub_Socket_Render+x} ]; then
		SPACES_AFTER_EMOJI=" "
	else
		SPACES_AFTER_EMOJI="  "
	fi
	

	# Define prompts
	setopt PROMPT_SUBST
	PROMPT="${wave_or_explode}%{$reset_color%}${SPACES_AFTER_EMOJI}"
	RPROMPT='$(wave_git_info)$(_machine_and_cwd)'
}

prompt_wave_setup "$@"
