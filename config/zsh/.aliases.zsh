#! /usr/bin/env zsh
#======================================================================
#
# .aliases.zsh -
#
# Created by liubang on 2023/03/18 00:43
# Last Modified: 2023/03/18 00:43
#
#======================================================================

alias s='neofetch'
alias ll='ls -lh'
alias la='ls -lAh'
alias diff='diff --color=auto'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias tree='tree -aC -I .git --dirsfirst'
alias gedit='gedit &>/dev/null'
alias d2u='dos2unix'
alias u2d='unix2dos'
alias zinit-update='zinit delete --all; zinit self-update;' 
# Make sudo use aliases
# https://unix.stackexchange.com/a/148548
alias sudo='sudo '
# nvim
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 /opt/app/nvim/bin/nvim'
alias php-81='/opt/app/php-81/bin/php'

# # Directory coloring
if [[ "$OS" =~ "Darwin" ]]; then
  export LSCOLORS="exgxdHdHcxaHaHhBhDeaec"
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
