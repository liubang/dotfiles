#!/bin/sh
nm-applet &
picom --experimental-backends &
/bin/bash ~/.dwm/wp-autochange.sh &
/bin/bash ~/.dwm/sxob.sh &
