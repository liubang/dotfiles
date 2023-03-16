#! /usr/bin/env zsh
#======================================================================
#
# .zshrc - 
#
# Created by liubang on 2019/05/23
# Last Modified: 2023/03/16 10:33
#
#======================================================================

setopt EXTENDED_GLOB
# Just in case: If the parent directory doesn't exist, create it.
# [[ -d $HISTFILE(:h) ]] || mkdir -p $HISTFILE(:h)
# Max number of entries to keep in history file.
SAVEHIST=$(( 100 * 1000 ))      # Use multiplication for readability.
# Max number of history entries to keep in memory.
HISTSIZE=$(( 1.2 * SAVEHIST ))  # Zsh recommended value
# Use modern file-locking mechanisms, for better safety & performance.
setopt HIST_FCNTL_LOCK
# Keep only the most recent copy of each duplicate entry in history.
setopt HIST_IGNORE_ALL_DUPS
# Auto-sync history between concurrent sessions.
setopt SHARE_HISTORY

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit -s

# Fix common locale issues (e.g. less, tmux).
#
export OS="$(uname -s)"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"
export LC_LANG="${LC_LANG:-en_US.UTF-8}"
export LESSCHARSET="${LESSCHARSET:-utf-8}"
[[ ${OS} =~ 'Linux' ]] && export LC_TIME="${LC_TIME:-C.UTF-8}"

# Enable colorized otput (e.g. for `ls`).
export CLICOLOR="${CLICOLOR:-yes}"

# Where to look for autoloaded function definitions
fpath=($fpath)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# +─────────────────────+
# │ LOAD CONFIGURATIONS │
# +─────────────────────+
source $HOME/.config/zsh/zinit.zsh
source $HOME/.config/zsh/p10k.zsh
source $HOME/.config/zsh/env.zsh
source $HOME/.config/zsh/utils.zsh
[[ -f "${HOME}/.custom.zsh" ]] && source "${HOME}/.custom.zsh"

# don't let > silently overwrite files. to overwrite, use >! instead.
setopt NO_CLOBBER
# treat comments pasted into the command line as comments, not code.
setopt INTERACTIVE_COMMENTS
# don't treat non-executable files in your $path as commands. this makes sure
# they don't show up as command completions. settinig this option can impact
# performance on older systems, but should not be a problem on modern ones.
setopt HASH_EXECUTABLES_ONLY
# enable ** and *** as shortcuts for **/* and ***/*, respectively.
# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Recursive-Globbing
setopt GLOB_STAR_SHORT
# sort numbers numerically, not lexicographically.
setopt NUMERIC_GLOB_SORT
zstyle ':completion:*' rehash true
