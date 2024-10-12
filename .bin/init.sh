#!/bin/zsh

# check operatiing system
if [ $(uname) != "Darwin" ]; then
  echo "This script is only for MacOS"
  exit 1
fi

echo "Setting up MacOS..."

# install xcode command line tools
if [ $(xcode-select -p) ]; then
  echo "Xcode command line tools are already installed"
else
  xcode-select --install
fi

# install homebrew
if [ $(which brew) ]; then
  echo "Homebrew is already installed"
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ $(uname -p) = "arm" ]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# create github directory
if [ -d /Users/$(whoami)/develop/repositories ]; then
  echo "github directory is already created"
else
  mkdir -p /Users/$(whoami)/develop/repositories
fi