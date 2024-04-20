HOME ?= "~/"

apply:
	rsync -av --delete ./config/bspwm ${HOME}/.config/
	rsync -av --delete ./config/btop ${HOME}/.config/
	rsync -av --delete ./config/cava ${HOME}/.config/
	rsync -av --delete ./config/dunst ${HOME}/.config/
	rsync -av --delete ./config/fcitx5 ${HOME}/.config/
	rsync -av --delete ./config/fontconfig ${HOME}/.config/
	rsync -av --delete ./config/kitty ${HOME}/.config/
	rsync -av --delete ./config/neofetch ${HOME}/.config/
	rsync -av --delete ./config/picom ${HOME}/.config/
	rsync -av --delete ./config/qtile ${HOME}/.config/
	rsync -av --delete ./config/sxhkd ${HOME}/.config/
	rsync -av --delete ./config/systemd ${HOME}/.config/
	rsync -av --delete ./config/zathura ${HOME}/.config/
	rsync -av --delete ./config/zsh ${HOME}/.config/

update:
	rsync -av --delete ${HOME}/.config/bspwm ./config/
	rsync -av --delete ${HOME}/.config/btop ./config/
	rsync -av --delete ${HOME}/.config/cava ./config/
	rsync -av --delete ${HOME}/.config/dunst ./config/
	rsync -av --delete ${HOME}/.config/fcitx5 ./config/
	rsync -av --delete ${HOME}/.config/fontconfig ./config/
	rsync -av --delete ${HOME}/.config/kitty ./config/
	rsync -av --delete ${HOME}/.config/neofetch ./config/
	rsync -av --delete ${HOME}/.config/picom ./config/
	rsync -av --delete ${HOME}/.config/qtile ./config/
	rsync -av --delete ${HOME}/.config/sxhkd ./config/
	rsync -av --delete ${HOME}/.config/systemd ./config/
	rsync -av --delete ${HOME}/.config/zathura ./config/
	rsync -av --exclude='*.zwc' --exclude=".zsh_history" --delete ${HOME}/.config/zsh ./config/
