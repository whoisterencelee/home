#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && `tmux detach-client; exec startx` #works but not so clean, rather make sure tmux doesn't start in same virtual console as startx ($XDG_VTNR=1) while not in XDG ($DISPLAY not set)

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
