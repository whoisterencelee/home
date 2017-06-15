#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f "$HOME/.config/monitor/this_monitor.sh" ]; then
	srandrd $HOME/.config/monitor/detect_displays.sh
#	$HOME/.config/monitor/this_monitor.sh
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# composite manager script, so background windows can be tinted
# $HOME/.xcomp.sh &

xset +fp /usr/share/fonts/wenquanyi/wqy-microhei-lite/

# silent the beep

xset -b

# window manager
exec i3
