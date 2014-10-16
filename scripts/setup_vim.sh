#!/usr/bin/env bash

SCRIPT_DIR=`dirname $0`
# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

install_vundle_plugins() {
    echo "Installing MacVim Vundle plugins now."
    vim -v +PluginInstall +qall
}

make_youcompleteme() {
    echo "Making MacVim plugin YouCompleteMe"
    pushd ../config/vim/bundle/YouCompleteMe
    ./install.sh --clang-completer --omnisharp-completer
    popd
}

make_command_t() {
    echo "Making Command-T"
    pushd ../config/vim/bundle/Command-T/ruby/command-t
    ruby extconf.rb
    make > /dev/null
    popd
}

main() {
    install_vundle_plugins
    make_youcompleteme
    make_command_t
    echo "Done"
}

main
