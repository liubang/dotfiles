#! /usr/bin/env zsh
# Copyright (c) 2024 The Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Authors: liubang (it.liubang@gmail.com)

gcc_macros() {
  gcc -E -dM - </dev/null
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

dots() { # quick lookup for my config files
  find ${DOTFILES:-$HOME/.config/dotfiles} | awk '!/git|plugged|autoload|.DS_Store/ && gsub("//", "/")' | fzfp | xargs $EDITOR
}

fzfp() { #fzf with preview options
  fzf \
    --ansi
  --bind '?:toggle-preview' \
    --inline-info \
    --preview='\
    [[ $(file --mime {}) =~ binary ]] \
    && echo {} is a binary file \
    || highlight --style base16/nord -O ansi -l {} \
    || cat {} 2> /dev/null | head -500' \
    --reverse \
    --tabstop=1

}

gli() {
  local filter
  if [ -n "$@" ] && [ -f "$@" ]; then
    filter="-- $@"
  fi
  git log \
    --graph --color=always --abbrev=7 --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr' "$@" \
    | fzf \
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
  ) \
    && local branch=$(echo "$branches" | fzf-tmux -d $((2 + $(wc -l <<< "$branches"))) +m) \
    && git checkout $(
      echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##"
    )
}

fglog() { # git log browser with FZF
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
    | fzf \
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
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" \
      | fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b
  ); do
    mapfile -t out <<< "$out"
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
