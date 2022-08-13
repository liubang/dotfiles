#======================================================================
#
# config.sh -
#
# Created by liubang on 2018/11/22
# Last Modified: 2018/11/22 21:45:30
#
#======================================================================

# for bspwm
if [ "${DESKTOP_SESSION}" = "bspwm" ]; then
  export _JAVA_AWT_WM_NONREPARENTING=1
fi

#----------------------------------------------------------------------
# develop
#----------------------------------------------------------------------
if [ "$OS" = "Linux" ]; then
  export JAVA_HOME="/opt/app/java"
  export GOROOT=/opt/app/go
elif [ "$OS" = "Darwin" ]; then
  export JAVA_HOME="$(/usr/libexec/java_home -v 18)"
  export GOROOT=/usr/local/go
  export CLANG_RESOURCEDIR="/Library/Developer/CommandLineTools/usr/lib/clang/13.0.0"
  export CLANG_ISYSTEM="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1"
  export CLANG_INCLUDE="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/"
fi

export PATH=$JAVA_HOME/bin:/opt/homebrew/bin:$PATH
# after jdk15, there is no need to set CLASSPATH
# export CLASSPATH=".:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$CLASSPATH"
export MAVEN_HOME=/opt/app/maven
export GRADLE_HOME=/opt/app/gradle

# golang
export GOPATH=${HOME}/.go
export GOBIN=$GOPATH/bin

# path
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/app/bin:$PATH"
export PATH="/opt/app/nvim/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin:$GOBIN:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# nodejs
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

# alias
alias ll='ls -lh'
alias la='ls -lAh'
alias diff='diff --color=auto'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias tree='tree -aC -I .git --dirsfirst'
alias gedit='gedit &>/dev/null'
alias d2u='dos2unix'
alias u2d='unix2dos'
alias zinit-update='zinit delete --all; zinit self-update;' 
alias kitty='GLFW_IM_MODULE=ibus $HOME/.local/kitty.app/bin/kitty'
# Make sudo use aliases
# https://unix.stackexchange.com/a/148548
alias sudo='sudo '
# nvim
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 /opt/app/nvim/bin/nvim'
alias php-81='/opt/app/php-81/bin/php'

# # Directory coloring
if [ "$OS" = "Darwin" ]; then
  export LSCOLORS="exgxdHdHcxaHaHhBhDeaec"
  # gnu sed
  if command -v gsed >/dev/null 2>&1; then
    alias sed=gsed
  fi
else
  alias ls='ls --group-directories-first --color=auto'
fi

if [ "$OS" = "Linux" ]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  alias open='xdg-open'
fi

# vim:ft=zsh:sw=2:sts=2
