#!/bin/zsh

# check operatiing system
if [ $(uname) != "Darwin" ]; then
  echo "This script is only for MacOS"
  exit 1
fi

brew bundle --global