#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

function install_env() {
  echo "Installing environment files"
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
  cp -v oh-my-zsh/* ~/.oh-my-zsh/custom/
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
