#!/usr/bin/env bash

# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

readonly PROGDIR=$(dirname $0)

function brew_install {
    FILE=logs/brew/${1}.log 
    brew install -f $1 2> ${FILE} > ${FILE}
    if [ $? -eq 0 ]
    then
        echo "brew - installed $1"
        rm ${FILE} 2> /dev/null
    else
        echo "Error installing $1 - see ${FILE}"
    fi
}

ensure_log_directories_exist() {
    mkdir -p logs/brew
    rm logs/*/*.log
}

install_essentials() {
    for P in bash bash-completion macvim git hg coreutils
    do
        brew_install ${P}
    done
}

install_utils() {
    for P in   \
        ag     \
        s3cmd  \
        wget
    do
        brew_install ${P}
    done
}

install_fonts() {
    echo "Installing fonts..."
    cp ../fonts/*/*.ttf ~/Library/Fonts/
    echo "Done installing fonts."
}

main() {
    source ${PROGDIR}/include.sh

    ensure_log_directories_exist

    install_essentials
    install_utils
    install_fonts
}

main
