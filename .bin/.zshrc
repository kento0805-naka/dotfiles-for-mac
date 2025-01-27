function left-prompt {
  name_text='179m%}'
  name_background='000m%}'
  path_text='255m%}'
  path_background='031m%}'
  arrow='087m%}'
  text_color='%{\e[38;5;'
  back_color='%{\e[30;48;5;'
  reset='%{\e[0m%}'
  sharp="\uE0B0"

  user="${back_color}${name_background}${text_color}${name_text}"
  dir="${back_color}${path_background}${text_color}${path_text}"
  echo "${user}%n(っ´ω\`c)♡${back_color}${path_background}${text_color}${name_background}${sharp} ${dir}%~${reset}${text_color}${path_background}${sharp}${reset}\n${text_color}${arrow}> ${reset}"
}

function git-current-branch {
  branch='\ue0a0'
  green='%{\e[38;5;114m%}'
  red='%{\e[38;5;001m%}'
  yellow='%{\e[38;5;227m%}'
  blue='%{\e[38;5;033m%}'
  reset='%{\e[0m%}'

  if ! git rev-parse 2> /dev/null; then
    return
  fi

  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`

  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    branch_status="${green}${branch}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    branch_status="${red}${branch}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    branch_status="${red}${branch}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    branch_status="${yellow}${branch}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    echo "${red}${branch}!(no branch)${reset}"
    return
  else
    branch_status="${blue}${branch}"
  fi

  echo "${branch_status}${branch_name}${reset}"
}

setopt prompt_subst

PROMPT='$(left-prompt)'
RPROMPT='$(git-current-branch)'

# zinitの設定
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

## zintコマンドを補完する設定
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zinitのプラグインの読み込み
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions

# ghqの初期設定
git config --global ghq.root '~/develop/repositories'

# pecoの設定
function peco-cd-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-cd-src
bindkey '^x' peco-cd-src

## ctrl + r で過去に実行したコマンドを選択できるようにする。
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

## go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -l'
alias la='ls -la'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gb='git branch'
alias gco='git checkout'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gds='git diff --staged'

# GNUコマンドを使うためのalias
alias date='gdate'
alias ls='gls'
alias mkdir='gmkdir'
alias cp='gcp'
alias mv='gmv'
alias rm='grm'
alias du='gdu'
alias head='ghead'
alias tail='gtail'
alias sed='gsed'
alias grep='ggrep'
alias find='gfind'
alias dirname='gdirname'
alias xargs='gxargs'

# kubernetes
alias k='kubectl'
. /opt/homebrew/opt/asdf/libexec/asdf.sh
