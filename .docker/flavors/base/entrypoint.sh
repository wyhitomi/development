#!/bin/sh
# vim:sw=4:ts=4:et

set -e

function install_zsh() {
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
}

vim +PluginInstall +qall