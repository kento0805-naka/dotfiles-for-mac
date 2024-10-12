PROMPT="%S%F{92}(%n)%s%S%f%F{135}%~%f%s%S%f%F{147}hoge%f%s "
RPROMPT="%T"

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