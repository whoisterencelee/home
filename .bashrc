#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable the beep
set -b

set -o vi

source .PS1

alias ls='ls --color=auto'
alias l='ls --color=auto -alrt'
eval "`dircolors -b $HOME/.dir_colors`"

source ~/.config/bookmarks/bookmarks.sh

export EDITOR='/bin/vim'

# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
# ignore space leading password command lines
HISTCONTROL=ignorespace

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f $HOME/serverless/node_modules/tabtab/.completions/serverless.bash ] && . $HOME/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f $HOME/serverless/node_modules/tabtab/.completions/sls.bash ] && . $HOME/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f $HOME/serverless/node_modules/tabtab/.completions/slss.bash ] && . $HOME/serverless/node_modules/tabtab/.completions/slss.bash


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
