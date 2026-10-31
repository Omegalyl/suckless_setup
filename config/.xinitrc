#!/bin/sh

# Start the session in $HOME so dwm (and every terminal it spawns) does not
# inherit whatever directory startx was run from.
cd "$HOME" || exit 1

# System xinitrc.d scripts (dbus/systemd env). ly already runs these via
# /etc/ly/setup.sh; startx does not, so source them here.
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

picom -b
feh --no-fehbg --bg-fill ~/fehbg &
slstatus &
dunst &

firefox &
easyeffects &
pavucontrol &
blueman-applet &

exec dwm
