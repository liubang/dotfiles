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

(( ${+TERM} )) || export TERM="xterm-256color"; COLORTERM="truecolor"
(( ${+USER} )) || export USER="${USERNAME}"
(( ${+XDG_CACHE_HOME} )) || export XDG_CACHE_HOME="${HOME}/.cache"
(( ${+XDG_CONFIG_HOME} )) || export XDG_CONFIG_HOME="${HOME}/.config"
(( ${+XDG_DATA_HOME} )) || export XDG_DATA_HOME="${HOME}/.local/share"

export OS="$(uname -s)"
export CLICOLOR=1
export GCC_COLORS=1
export EDITOR=nvim
export GIT_EDITOR=nvim
export GPG_TTY=$TTY

# 设置 core dump 大小
ulimit -c unlimited
# 设置最大文件描述符数
ulimit -n 1048576
# 设置最大进程数
ulimit -u 65535

# for bspwm
if [[ "${DESKTOP_SESSION}" =~ "bspwm" ]]; then
  export _JAVA_AWT_WM_NONREPARENTING=1
fi

#----------------------------------------------------------------------
# develop
#----------------------------------------------------------------------
if [[ "$OS" =~ "Linux" ]]; then
  export JAVA_HOME="/opt/app/java"
  export GOROOT=/opt/app/go
elif [[ "$OS" = "Darwin" ]]; then
  export JAVA_HOME="$(/usr/libexec/java_home -v 17)"
  export GOROOT=/usr/local/go
  export PATH="/opt/homebrew/bin:$PATH"
fi

export MAVEN_HOME=/opt/app/maven
export GRADLE_HOME=/opt/app/gradle

# golang
export GOPATH=${HOME}/.go
export GOBIN=$GOPATH/bin

export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/app/bin:$PATH"
export PATH="/opt/app/nvim/bin:$PATH"
export PATH="/opt/app/redis/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin:$GOBIN:$PATH"
export PATH="/opt/app/node/bin:$PATH"
export PATH="/opt/app/llvm/bin:$PATH"

# ruby
if [ -d "/usr/local/opt/ruby/bin" ]; then
  export PATH="/usr/local/opt/ruby/bin:$PATH"
  export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
fi

# pyenv
# if command -v pyenv 1>/dev/null 2>&1; then
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PYTHON3_HOST_PROG="$PYENV_ROOT/shims/python3"
  eval "$(pyenv init -)"
else
  export PYTHON3_HOST_PROG="$(which python3)"
fi
export PYTHON_HOST_PROG="$(which python2)"

# php
if [ -d "/opt/app/php82" ]; then
  export PATH="/opt/app/php82/bin:$PATH"
fi

# bcloud
if [ -d "$HOME/.BCloud/bin" ]; then
  export PATH=$HOME/.BCloud/bin:$PATH
fi

# rust
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# cargo
[ -f "$HOME/.cargo/env" ] && source $HOME/.cargo/env

source $HOME/.local/share/../bin/env

# 整理 PATH，删除重复路径
if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}
        case $PATH: in
           *:"$x":*) ;;
           *) PATH=$PATH:$x;;
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi
export PATH

# vim: set fenc=utf8 ffs=unix ft=zsh list et sts=2 sw=2 ts=2 tw=100:
