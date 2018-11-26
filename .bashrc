#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable the beep
set -b

set -o vi

alias ls='ls --color=auto'
alias l='ls --color=auto -alrt'

source .PS1

# ignore space leading password command lines
HISTCONTROL=ignorespace

source ~/.config/bookmarks/bookmarks.sh

export EDITOR='/bin/vim'

eval "`dircolors -b $HOME/.dir_colors`"

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh

# TMUX
if `which tmux 2>&1 >/dev/null` && [ -z $TMUX ] ; then
# check if tmux is on system
# tmux doesn't nest nicely, check $TMUX which is only set within the tmux session

	if [[ -n "$DISPLAY" || -z $XDG_VTNR ]]; then
	# check not in a virtual console
	# but allow remote terminals
		tmux -q attach || tmux
		exit

	#elif [ $XDG_VTNR -ne 1 ] ; then
	# since if tmux dies/quits X goes with it, need to prevent tmux starting in tty1 which will startx
		#tmux
		#env >> here2.txt
		# tmux should be started individually for each tty, as splitting pane in tty crashes other tty anyways

	fi

	# when quitting tmux, try to attach
	#while test `tmux -q has-session`; do
	#	tmux attach || break
	#done

fi
