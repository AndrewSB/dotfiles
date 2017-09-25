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

function _source_fb_scm_prompt() {
	local fb_prompt_file="${LOCAL_ADMIN_SCRIPTS}/scm-prompt"
	if [ -f "$fb_prompt_file" ]; then
		source "$fb_prompt_file"
	else
		echo "couldn't find FB SCM prompt file ${fb_prompt_file}"
	fi
}

function prompt_wave_precmd {
	FB_PROMPT="$(_scm_prompt)"
}

function prompt_wave_setup {
	autoload -Uz add-zsh-hook # Loads required functions

	add-zsh-hook precmd prompt_wave_precmd # Adds hook for calling prompt_waveprecmd before each command

	_source_fb_scm_prompt
	
	# auto ls on empty line
	zle -N accept-line auto_ls
	zle -N other-widget auto_ls

	local wave_or_explode="%(?:%{$fg_bold[green]%}👋:%{$fg_bold[red]%}💥)"
	SPACES_AFTER_EMOJI=" "

	# Define prompts
	setopt PROMPT_SUBST
	PROMPT="${wave_or_explode}%{$reset_color%}${SPACES_AFTER_EMOJI}"
	RPROMPT='${FB_PROMPT} $(_machine_and_cwd)${SPACES_AFTER_EMOJI}'
}

prompt_wave_setup "$@"
