#======================================================================
#
# init.sh -
#
# Created by liubang on 2018/11/22
# Last Modified: 2018/11/22 18:28:03
#
#======================================================================

# 交互式模式的初始化脚本
# 防止被加载两次
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# skip if in non-interactive mode
case "$-" in
    *i*) ;;
    *) return
esac

# get current script path
SHELL_ROOT=$(
    cd "$(dirname "$0")" || return
    pwd
)

case "$OSTYPE" in
darwin*)
    export INIT_OS_TYPE="macos"
    ;;
freebsd*)
    export INIT_OS_TYPE="freebsd"
    ;;
linux*)
    export INIT_OS_TYPE="linux"
    ;;
esac

# 将个人 ~/.local/bin 目录加入 PATH
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# theme
[ -f "${SHELL_ROOT}/p10k.zsh" ] && . "${SHELL_ROOT}/p10k.zsh"

# alias
[ -f "${SHELL_ROOT}/alias.zsh" ] && . "${SHELL_ROOT}/alias.zsh"

# config
[ -f "${SHELL_ROOT}/config.zsh" ] && . "${SHELL_ROOT}/config.zsh"

# custom
[ -f "${HOME}/.custom.zsh" ] && . "${HOME}/.custom.zsh"

# 整理 PATH，删除重复路径
if [ -n "$PATH" ]; then
    old_PATH=$PATH:
    PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}
        case $PATH: in
        *:"$x":*) ;;
        *) PATH=$PATH:$x ;;
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi

export PATH

[ -f "${SHELL_ROOT}/function.zsh" ] && . "${SHELL_ROOT}/function.zsh"
