#!/bin/sh
nm-applet &
picom --experimental-backends &
/bin/bash ~/.dwm/wp-autochange.sh &
fcitx5 -d
