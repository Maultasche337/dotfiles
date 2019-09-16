#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

function install_env() {
  echo "Installing environment files"
  cp -v env/.* ~/
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
  vim)
    install_vim
    ;;
  *)
    echo "Available commands:"
    echo "env"
    echo "vim"
    ;;
esac
