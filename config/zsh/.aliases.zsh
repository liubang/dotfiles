#! /usr/bin/env zsh
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

alias s='neofetch'
alias ll='ls -lh'
alias la='ls -lAh'
alias diff='diff --color=auto'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias d2u='dos2unix'
alias u2d='unix2dos'
# Make sudo use aliases
# https://unix.stackexchange.com/a/148548
alias sudo='sudo '
# nvim
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 /opt/app/nvim/bin/nvim'

# # Directory coloring
if [[ "$OS" =~ "Darwin" ]]; then
  # gnu sed
  if command -v gsed >/dev/null 2>&1; then
    alias sed=gsed
  fi
fi

if [[ "$OS" =~ "Linux" ]]; then
  alias ls='ls --group-directories-first --color=auto'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  alias open='xdg-open'
  alias kitty='GLFW_IM_MODULE=ibus $HOME/.local/kitty.app/bin/kitty'
fi

# vim: set fenc=utf8 ffs=unix ft=zsh list et sts=2 sw=2 ts=2 tw=100:
