#! /usr/bin/env zsh
#======================================================================
#
# config.zsh -
#
# Created by liubang on 2018/11/22
# Last Modified: 2023/03/16 10:33
#
#======================================================================

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
export GIT_CONFIG="$XDG_CONFIG_HOME"/git/config

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
  export CLANG_RESOURCEDIR="/Library/Developer/CommandLineTools/usr/lib/clang/13.0.0"
  export CLANG_ISYSTEM="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1"
  export CLANG_INCLUDE="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/"
fi

export MAVEN_HOME=/opt/app/maven
export GRADLE_HOME=/opt/app/gradle

# golang
export GOPATH=${HOME}/.go
export GOBIN=$GOPATH/bin

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/app/bin:$PATH"
export PATH="/opt/app/nvim/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin:$GOBIN:$PATH"
export PATH="/opt/app/node/bin:$PATH"

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

# bcloud
if [ -d "$HOME/.BCloud/bin" ]; then
  export PATH=$HOME/.BCloud/bin:$PATH
fi

# bazel-compilation-database
if [ -d "/opt/app/bazel-compilation-database" ]; then
  export PATH="/opt/app/bazel-compilation-database:$PATH"
fi

# cargo
[ -f "$HOME/.cargo/env" ] && source $HOME/.cargo/env

# vim: set fenc=utf8 ffs=unix ft=zsh list et sts=2 sw=2 ts=2 tw=100:
