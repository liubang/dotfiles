# Copyright (c) 2024 The Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Authors: liubang (it.liubang@gmail.com)

HOME ?= "~/"

apply:
	rsync -av --delete ./config/bspwm ${HOME}/.config/
	rsync -av --delete ./config/btop ${HOME}/.config/
	rsync -av --delete ./config/mpv ${HOME}/.config/
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
	rsync -av --delete ${HOME}/.config/mpv ./config/
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
