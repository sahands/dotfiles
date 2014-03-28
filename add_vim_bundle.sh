#!/opt/local/bin/bash

if [ $# -ne 1 ]
then
    echo "Syntax: add_vim_bundle.sh git_repository_url"
else
    cd dotfiles/vim/bundle
    git clone $1
    cd ../..
    DIR=${1##*/}
    DIR=${DIR%.git}
    echo "Adding $DIR as an external repository."
    echo "dotfiles/vim/bundle/$DIR = [git]$1" >> .hgsub
    echo "Done."
fi
