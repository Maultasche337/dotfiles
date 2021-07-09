#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

function install_env() {
  echo "Installing environment files"
  cp -v env/.alacritty.yml ~/
  cp -v env/.gitconfig ~/
  cp -v env/.gitignore_global ~/
  cp -v env/.npmrc ~/
  cp -v env/.sqliterc ~/
  cp -v env/.tmux.conf ~/
  echo "Done."
}

function install_exa() {
  echo "Installing exa"
  cd /tmp/
  wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
  sudo apt -y install unzip
  unzip exa-linux-x86_64-0.9.0.zip
  sudo cp exa-linux-x86_64 /usr/local/bin/exa
  rm exa-linux-x86_64 exa-linux-x86_64-0.9.0.zip
}

function install_omz() {
  echo "Installing oh-my-zsh files"

  echo "common"
  cp -v oh-my-zsh/common/* ~/.oh-my-zsh/custom/

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # TODO distro specific
    echo "linux-gnu"
    cp -v oh-my-zsh/linux/* ~/.oh-my-zsh/custom/
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    echo "macos"
    cp -v oh-my-zsh/macos/* ~/.oh-my-zsh/custom/
  elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    echo "cygwin"
  elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    echo "msys"
  elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    echo "win32"
  elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "freebsd"
  else
    echo "unknown"
  fi

  echo "Done."
}

function install_vim() {
  echo "Installing vim files"
  rm -rf ~/.vim/ ~/.vimrc
  cp -v env/.vimrc ~/.vimrc
  mkdir -p ~/.vim/bundle
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
  echo "Done."
}

case $1 in
  env)
    install_env
    ;;
  exa)
    install_exa
    ;;
  omz)
    install_omz
    ;;
  vim)
    install_vim
    ;;
  *)
    echo "Available commands:"
    echo "env"
    echo "exa - Install exa (ls replacement)"
    echo "omz - Install oh-my-zsh files"
    echo "vim"
    ;;
esac
