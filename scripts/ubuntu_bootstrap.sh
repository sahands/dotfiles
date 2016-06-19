#!/usr/bin/env bash

# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(dirname $0)
readonly ARGS="$@"

source ${PROGDIR}/include.sh
ensure_root

ensure_log_directories_exist() {
    mkdir -p logs/pip
    mkdir -p logs/port
    rm logs/*/*.log
}

function apt_get_install {
    LOGFILE=logs/port/${1}.log 
    apt-get install $1 2> ${LOGFILE} > ${LOGFILE}
    if [ $? -eq 0 ]
    then
        echo "apt-get - installed $1"
        rm ${LOGFILE} 2> /dev/null
    else
        echo "Error installing $1 - see ${LOGFILE}"
    fi
}

install_essentials() {
    for P in vim git
    do
        apt_get_install ${P}
    done
}

main() {
    ensure_log_directories_exist
    install_essentials
}

main
