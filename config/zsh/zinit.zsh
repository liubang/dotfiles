#! /usr/bin/env zsh
#======================================================================
#
# zinit.zsh -
#
# Created by liubang on 2022/08/13 21:35
# Last Modified: 2023/03/16 14:36
#
#======================================================================

# helper methods
error() { builtin print -P "%F{red}[ERROR]%f: %F{yellow}$1%f" && return 1; }
info() { builtin print -P "%F{blue}[INFO]%f: %F{cyan}$1%f"; }

# zinit
typeset -gAH ZI=(HOME_DIR $HOME/.local/share/zinit)
ZI+=(
  BIN_DIR "$ZI[HOME_DIR]/zinit.git" COMPLETIONS_DIR "$ZI[HOME_DIR]/completions" OPTIMIZE_OUT_OF_DISK_ACCESSES "1"
  PLUGINS_DIR "$ZI[HOME_DIR]/plugins" SNIPPETS_DIR "$ZI[HOME_DIR]/snippets" ZCOMPDUMP_PATH "${ZDOTDIR:-$HOME/.config/zsh}/.zcompdump"
  ZPFX "$ZI[HOME_DIR]/polaris" SRC 'zdharma-continuum' BRANCH 'main'
)
ZSH_CACHE_DIR=$ZINIT[ZCOMPDUMP_PATH]
if [[ ! -e $ZI[BIN_DIR]/zinit.zsh ]]; then
  {
    info 'downloading zinit'
    command git clone \
      --branch ${ZI[BRANCH]:-main} \
      https://github.com/${ZI[FORK]:-${ZI[SRC]}}/zinit.git \
      ${ZI[BIN_DIR]}
    info 'setting up zinit'
    command chmod g-rwX ${ZI[HOME_DIR]} && \
      zcompile "${ZI[BIN_DIR]}/zinit.zsh"
    info 'installed zinit'
  } || error 'failed to download zinit'
fi
if [[ -e ${ZI[BIN_DIR]}/zinit.zsh ]]; then
  typeset -gAH ZINIT=( ${(kv)ZI} )
  builtin source ${ZINIT[BIN_DIR]}/zinit.zsh && \
    autoload _zinit && \
    (( ${+_comps} )) && \
    _comps[zinit]=_zinit
else 
    error 'failed to find zinit installation'
fi

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

#=== OH-MY-ZSH & PREZTO PLUGINS =======================
zi is-snippet nocompletions light-mode compile light-mode for \
  {PZTM::environment,OMZL::{compfix,git,key-bindings,completion}.zsh}
zi as'completion' for OMZP::{'golang/_golang','pip/_pip'}

# #=== COMPLETIONS ======================================
local GH_RAW_URL='https://raw.githubusercontent.com'
znippet() { zi for  as'completion' has"${1}" depth'1' light-mode nocompile id-as"${1}-completion/_${1}" is-snippet "${GH_RAW_URL}/${2}/_${1}"; }
znippet 'exa' 'ogham/exa/master/completions/zsh'
znippet 'brew' 'Homebrew/brew/master/completions/zsh'
znippet 'docker' 'docker/cli/master/contrib/completion/zsh'
zi  as'completion' light-mode nocompile is-snippet for \
  "${GH_RAW_URL}/git/git/master/contrib/completion/git-completion.zsh" \
  "${GH_RAW_URL}/Homebrew/homebrew-services/master/completions/zsh/_brew_services"

#=== PROMPT ===========================================
# After finishing the configuration wizard change the atload'' ice to:
# -> atload'source ~/.p10k.zsh;
zi ice wait'!' lucid
zi ice depth=1; zinit light romkatv/powerlevel10k

#=== ANNEXES ==========================================
zi light-mode for @${ZI[SRC]}/zinit-annex-{binary-symlink,default-ice,linkman,patch-dl,submods,bin-gem-node}

#=== MISC. ============================================
zi lucid wait light-mode depth'1' for \
  skywind3000/z.lua \
  zdharma-continuum/history-search-multi-word \
  atpull'zinit creinstall -q .' blockf null \
  zsh-users/zsh-completions \
  svn submods'zsh-users/zsh-completions -> external' \
  PZTM::completion \
  atload'!_zsh_autosuggest_start' atinit'bindkey "^_" autosuggest-execute;bindkey "^ " autosuggest-accept;' \
  zsh-users/zsh-autosuggestions
zi ice lucid wait'0c' depth'1' atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' atpull'%atclone' compile'.*fast*~*.zwc'
zi light "${ZI[FORK]:-${ZI[SRC]}}"/fast-syntax-highlighting
autoload select-word-style
select-word-style normal
zstyle ':zle:*' word-chars '*?[]~;!#$%^(){}<>'

# zsh-autosuggestions color
typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#928374'

zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold" # Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
zstyle ":history-search-multi-word" page-size "10"                    # Number of entries to show (default is $LINES/3)
zstyle ":plugin:history-search-multi-word" active "underline"        # Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ":plugin:history-search-multi-word" check-paths "yes"         # Whether to check paths for existence and mark with magenta (default true)
zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"      # Whether pressing Ctrl-C or ESC should clear entered query
zstyle ":plugin:history-search-multi-word" synhl "yes"               # Wh

#=== GITHUB BINARIES ==================================
# zinit wait lucid from"gh-r" as"command" for sbin"**/bin/nvim" ver"nightly" neovim/neovim
zi default-ice --quiet from"gh-r" light-mode lbin'!' nocompile
zi from'gh-r' lbin'!' nocompile for \
  @{'junegunn/fzf','sharkdp/'{'fd','hyperfine','bat'}} \
  lbin'!**/rg'       @BurntSushi/ripgrep
zi default-ice --clear --quiet
zi default-ice --quiet light-mode depth'1'

# vim: set expandtab filetype=zsh shiftwidth=2 softtabstop=2 tabstop=2:
