#! /usr/bin/env zsh
#======================================================================
#
# .zshenv - 
#
# Created by liubang on 2022/08/14 00:37
# Last Modified: 2022/08/14 00:37
#
#======================================================================

# +─────────────────+
# │ # ENV VARIABLES │
# +─────────────────+
(( ${+LANGUAGE} )) || export LANGUAGE="$LANG"
(( ${+USER} )) || export USER="$USERNAME"
(( ${+XDG_CACHE_HOME} )) || export XDG_CACHE_HOME="$HOME/.cache"
(( ${+XDG_CONFIG_HOME} )) || export XDG_CONFIG_HOME="$HOME/.config"
(( ${+XDG_DATA_HOME} )) || export XDG_DATA_HOME="$HOME/.local/share"

export CLICOLOR=1
export GCC_COLORS=1
export EDITOR=nvim
export GIT_EDITOR=nvim
export GIT_CONFIG="$XDG_CONFIG_HOME"/git/config
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# skip_global_compinit=1

# vim:ft=zsh:sw=2:sts=2
