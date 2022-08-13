#! /usr/bin/env zsh
#======================================================================
#
# zinit.zsh - 
#
# Created by liubang on 2022/08/13 21:35
# Last Modified: 2022/08/13 21:35
#
#======================================================================

# helper methods
error() { builtin print -P "%F{red}[ERROR]%f: %F{yellow}$1%f" && return 1; }
info() { builtin print -P "%F{blue}[INFO]%f: %F{cyan}$1%f"; }
# zinit
typeset -gAH ZI=(HOME_DIR "$HOME/.local/share/zinit")
ZI+=(
  BIN_DIR "$ZI[HOME_DIR]/zinit.git" COMPLETIONS_DIR "$ZI[HOME_DIR]/completions" OPTIMIZE_OUT_OF_DISK_ACCESSES "1"
  PLUGINS_DIR "$ZI[HOME_DIR]/plugins" SNIPPETS_DIR "$ZI[HOME_DIR]/snippets" ZCOMPDUMP_PATH "$ZI[HOME_DIR]/zcompdump"
)
ZI_FORK='vladdoster'; ZI_REPO='zdharma-continuum'; ZPFX=$ZI[HOME_DIR]/polaris
if [[ ! -e $ZI[BIN_DIR]/zinit.zsh ]] {
  info 'downloading zinit' \
    && command git clone "https://github.com/$ZI_REPO/zinit.git" $ZI[BIN_DIR]
  info 'setting up zinit' \
    && command chmod g-rwX $ZI[HOME_DIR] \
    && zcompile $ZI[BIN_DIR]/zinit.zsh \
    && info 'sucessfully installed zinit'
}

if [[ -e $ZI[BIN_DIR]/zinit.zsh ]] {
  typeset -gAH ZINIT=( ${(kv)ZI} ) \
    && builtin source $ZINIT[BIN_DIR]/zinit.zsh \
    && autoload -Uz _zinit \
    && (( ${+_comps} )) \
    && _comps[zinit]=_zinit
} else { error 'failed to find zinit installation' }

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# After finishing the configuration wizard change the atload'' ice to:
# -> atload'source ~/.p10k.zsh;
zinit ice wait'!' lucid
zinit ice depth=1; zinit light romkatv/powerlevel10k

# static zsh binary 
zi nocompletions is-snippet for OMZL::{'compfix','completion','git'}.zsh
zi nocompletions is-snippet for PZT::modules/{'environment','history','rsync'}
zi as'completion' for OMZP::{'golang/_golang','pip/_pip','terraform/_terraform'}

# completions
local GH_RAW_URL='https://raw.githubusercontent.com'
znippet() { zi for as'completion' has"${1}" nocompile id-as"${1}-completion/_${1}" is-snippet "${GH_RAW_URL}/${2}/_${1}"; }
znippet 'brew' 'Homebrew/brew/master/completions/zsh'
znippet 'docker' 'docker/cli/master/contrib/completion/zsh'
znippet 'exa' 'ogham/exa/master/completions/zsh'
znippet 'fd' 'sharkdp/fd/master/contrib/completion'

# extension
zi light zdharma-continuum/zinit-annex-binary-symlink

# ls colors
zi ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zi light trapd00r/LS_COLORS

# Autosuggestions & fast-syntax-highlighting
zi wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# zdharma-continuum/history-search-multi-word
zi ice wait"1" lucid
zi load zdharma-continuum/history-search-multi-word

zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold" # Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
zstyle ":history-search-multi-word" page-size "8"                    # Number of entries to show (default is $LINES/3)
zstyle ":plugin:history-search-multi-word" active "underline"        # Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ":plugin:history-search-multi-word" check-paths "yes"         # Whether to check paths for existence and mark with magenta (default true)
zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"      # Whether pressing Ctrl-C or ESC should clear entered query
zstyle ":plugin:history-search-multi-word" synhl "yes"               # Wh

# program
zi from'gh-r' lbin'!' nocompile for \
  @{'junegunn/fzf','sharkdp/'{'fd','hyperfine','bat'}} \
  lbin'!**/rg'       @BurntSushi/ripgrep 
