#======================================================================
#
# .zshrc - 
#
# Created by liubang on 2019/05/23
# Last Modified: 2019/05/23 11:12:49
#
#======================================================================

OS="$(uname -s)"

# skip if in non-interactive mode
case "$-" in
    *i*) ;;
    *) return
esac

if [[ ! -d "${MY_CONFIG}" ]]; then
    export MY_CONFIG="$HOME/.config/zsh"
fi

# my config file
[[ -f "$MY_CONFIG/init.zsh" ]] && source "$MY_CONFIG/init.zsh"

# enable proxy
# q_set_http_proxy
type BeforeInstallPlug &>/dev/null && BeforeInstallPlug 

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin"
fi

# zinit
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice wait'!'
zinit snippet OMZ::lib/git.zsh
zinit ice wait'!'
zinit snippet OMZP::git
zinit ice wait'!'
zinit snippet OMZP::ssh-agent
zinit ice wait'!'
zinit snippet OMZP::colored-man-pages

# theme 
zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit wait lucid for \
 silent atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 as"completion" \
    zsh-users/zsh-completions \
 atload"!export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=yellow,fg=white,bold'" \
    zsh-users/zsh-history-substring-search \
 pick"z.sh" \
    rupa/z \
 pick"fz.plugin.zsh" \
    changyuheng/fz \
 pick"git-it-on.plugin.zsh" \
    peterhurford/git-it-on.zsh

# Automatically refresh completions
zstyle ':completion:*' rehash true
# Highlight currently selected tab completion
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _expand _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' group-name '' # group results by category

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Use hyphen-insensitive completion. Case sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Include dotfiles in completions
setopt globdots

# homebrew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# pip zsh completion
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip

# screenfetch
