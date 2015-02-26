#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

alias ls='ls --color=auto'

export PS1='\
\[\e[00;`expr \`printf "%u" "'\''$(whoami)"\` % 6 + 31`m\]\u\[\e[m\]\
 \[\e[00;`expr \`printf "%u" "'\''$(hostname)"\` % 6 + 31`m\]\h\[\e[m\]\
 \[\e[00;36m\]`date +"%F\[\e[m\]\[\e[00;32m\] %T\[\e[m\]"`\
`load=\`sed "s/\([0-9]*\)[.]\([0-9]*\).*/1\1\2/" /proc/loadavg\`;if [[ $load -gt 1090 ]];then echo -n " \[\e[00;31m\]LOAD>\`expr $load - 1000\`%\[\e[m\]";fi`\
`ramexp=\`sed -n "N;s/^MemTotal:\\s*\\([0-9]*\\) .*\\nMemFree:\\s*\\([0-9]*\\) .*/\\200 \\/ \\1/p" /proc/meminfo\`;ram=\`expr $ramexp\`;if [[ $ram -lt 10 ]];then echo -n " \[\e[00;31m\]RAM<$ram%\[\e[m\]";fi`\
`disk=\`df . | sed -n "s/.* \([1-9]*[0-9]\)%.*/\1/p"\`;if [ $disk ];then if [[ $disk -gt 87 ]];then echo -n " \[\e[00;31m\]DISK>$disk%\[\e[m\]";fi;fi`\
 \[\e[00;$(if [[ ! -w $PWD ]];then echo -n 31;fi)m\]\w/\[\e[m\]\
 '

eval "`dircolors -b $HOME/.dir_colors`"

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
