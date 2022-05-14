#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}



run sxhkd &
run dunst &
run nm-applet &
run fcitx5 -d
run picom --experimental-backends -b

feh --no-fehbg --bg-scale "$HOME/.config/bspwm/wallpaper.png"
bash $HOME/.config/bspwm/polybar/launch.sh
xsetroot -cursor_name left_ptr
