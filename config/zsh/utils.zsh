#! /usr/bin/env zsh
#======================================================================
#
# utils.zsh -
#
# Created by liubang on 2018/11/22
# Last Modified: 2023/03/16 10:33
#
#======================================================================

q_weather() {
  local city="${1:-beijing}"
  if [ -x "$(which wget)" ]; then
    wget -qO- "wttr.in/~${city}"
  elif [ -x "$(which curl)" ]; then
    curl "wttr.in/~${city}"
  fi
}

# get all IPs
q_ips() {
  case $(uname) in
    Darwin | *BSD)
      ip=$(ifconfig | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}')
      ;;
    *)
      ip=$(hostname --all-ip-addresses | tr " " "\n" | grep -v "0.0.0.0" | grep -v "127.0.0.1")
      ;;
  esac
  echo "${ip}"
}

# get public IP
q_myip() {
  if command -v curl &>/dev/null; then
    curl ifconfig.co
  elif command -v wget &>/dev/null; then
    wget -qO- ifconfig.co
  fi
}

q_set_http_proxy() {
  proxy="http://127.0.0.1:7890"
  export HTTP_PROXY=$proxy
  export HTTPS_PROXY=$proxy
  export http_proxy=$proxy
  export https_proxy=$proxy
}

q_unset_http_proxy() {
  unset http_proxy
  unset https_proxy
  unset HTTP_PROXY
  unset HTTPS_PROXY
}

export FZF_COMPLETION_OPTS='--preview "bat --color=always --line-range :50 {} 2> /dev/null || head -50 {}"'
export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --exact --prompt=">>> "'

gli() {
  local filter
  if [ -n "$@" ] && [ -f "$@" ]; then
    filter="-- $@"
  fi
  git log \
    --graph --color=always --abbrev=7 --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr' "$@" |
    fzf \
      --ansi --no-sort --reverse --tiebreak=index --height 80% --preview-window=right:60% \
      --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}" \
      --bind "j:down,k:up,alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"

}

fgco() { # checkout git branch (including remote branches) with FZF
  local branches=$(
    git branch --all | grep -v HEAD
  ) &&
    local branch=$(echo "$branches" | fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
    git checkout $(
      echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##"
    )
}

fglog() { # git log browser with FZF
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf \
      --ansi \
      --bind=ctrl-s:toggle-sort \
      --no-sort \
      --reverse \
      --tiebreak=index \
      --bind "ctrl-m:execute:\
    (grep -o '[a-f0-9]\{7\}' \
      | head -1 \
      | xargs -I % sh -c 'git show --color=always % \
      | less -R'
  ) << 'FZF-EOF' {} FZF-EOF"
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
      fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b
  ); do
    mapfile -t out <<<"$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z $sha ]] && continue
    if [[ $k == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ $k == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break
    else
      git stash show -p $sha
    fi
  done
}

fmux() {
  set -euo pipefail
  prj=$(find $XDG_CONFIG_HOME/tmuxp/ -execdir bash -c 'basename "${0%.*}"' {} ';' | sort | uniq | nl | fzf | cut -f 2)
  tmuxp load $prj
}

ftmux() { # ftmux - help you choose tmux sessions
  if [[ -z $TMUX ]]; then
    # get the IDs
    ID="$(tmux list-sessions)"
    if [[ -z $ID ]]; then
      tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="$(echo $ID | fzf | cut -d: -f1)"
    if [[ $ID == "${create_new_session}" ]]; then
      tmux new-session
    elif [[ -n $ID ]]; then
      printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
      tmux attach-session -t "$ID"
    else
      : # Start terminal normally
    fi
  fi
}
