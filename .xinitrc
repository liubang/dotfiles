# init keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export $(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
dbus-update-activation-environment --systemd DISPLAY
# export keyring globals
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# override style for QT applications
export QT_STYLE_OVERRIDE=gtk

# Get list of desktop files in ~/.config/autostart
# mapfile -t dfiles < <(find "$HOME/.config/autostart" -iname '*.desktop')

# Launch all desktop files
# for f in "${dfiles[@]}"; do
#     name="${f#$HOME/.config/autostart/}"
#     gtk-launch "$name" &
# done

while true; do
    dwm 2>&1 | while read line; do echo "[$(date "+%b %d %T")] $line" >> ~/.dwm.log; done
done
