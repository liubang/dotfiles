# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:'                       auto-update            'no'
zstyle ':z4h:'                       auto-update-days       '28'
zstyle ':z4h:bindkey'                keyboard               'pc'
zstyle ':z4h:'                       start-tmux             no
zstyle ':z4h:'                       term-shell-integration 'yes'
zstyle ':z4h:autosuggestions'        forward-char           partial-accept
zstyle ':z4h:autosuggestions'        end-of-line            partial-accept
zstyle ':z4h:fzf-history'            fzf-preview            no
zstyle ':z4h:direnv'                 enable                 'no'
zstyle ':z4h:direnv:success'         notify                 'yes'
zstyle ':z4h:ssh:*'                  enable                 'no'

# install packages
z4h install romkatv/archive

# init z4h
z4h init || return

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
# setopt no_auto_menu  # require an extra TAB press to open the completion menu
setopt glob_dots magic_equal_subst no_multi_os no_local_loops
setopt rm_star_silent rc_quotes glob_star_short

ulimit -c $(((4 << 30) / 512))  # 4GB

# Extend PATH.
fpath=($Z4H/romkatv/archive $fpath)

path=(~/bin $path)

# Source additional local files if they exist.
z4h source -c "$ZDOTDIR"/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
# z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+/             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv archive lsarchive unarchive

# Define aliases.
z4h source -c "$ZDOTDIR"/.aliases.zsh
# Some custom functions
z4h source -c "$ZDOTDIR"/.utils.zsh
# Machine specified config
z4h source -c "$HOME/.custom.zsh"
