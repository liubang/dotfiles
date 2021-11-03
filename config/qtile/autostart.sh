#!/bin/bash

arr=("fcitx5" "nm-applet")

for value in ${arr[@]}; do
    if [[ ! $(pgrep ${value}) ]]; then
        exec "$value" &
    fi
done

picom --experimental-backends -b

# if [[ ! $(pgrep xob) ]]; then
#     exec "sxob"
# fi
