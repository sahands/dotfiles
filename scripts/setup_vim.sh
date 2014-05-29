#!/usr/bin/env bash

SCRIPT_DIR=`dirname $0`
# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

# Readonly globals
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(greadlink -m $(dirname $0))
readonly ARGS="$@"

main() {
    source $PROGDIR/include.sh
    # Install Vundle plugins
    echo "Installing MacVim Vundle plugins now."
    mvim -v +PluginInstall +qall

    # Making YouCompleteMe
    echo "Making MacVim plugin YouCompleteMe"
    cd ../config/vim/bundle/YouCompleteMe
    ./install.sh --clang-completer --omnisharp-completer

    # Making Command-T
    echo "Making Command-T"
    cd ../Command-T/ruby/command-t
    ruby extconf.rb
    make > /dev/null

    cd ../../../../scripts
    echo "Done"
}

main
