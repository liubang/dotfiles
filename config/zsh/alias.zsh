#======================================================================
#
# alias.sh -
#
# Created by liubang on 2019/05/23
# Last Modified: 2019/05/23 13:08:53
#
#======================================================================

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

# Directory coloring
if which gls >/dev/null 2>&1; then
	# Prefer GNU version, since it respects dircolors.
	alias ls='gls --group-directories-first --color=auto'
elif [ "$OS" = "Darwin" ]; then
	export CLICOLOR="YES" # Equivalent to passing -G to ls.
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
