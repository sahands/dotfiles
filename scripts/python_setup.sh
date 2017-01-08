#!/usr/bin/env bash

# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

# Version of Python to use
# readonly PY=34
# readonly PYV="3.4"
readonly PY=27
readonly PYV="2.7"

function pip_install {
    FILE=logs/pip/${1}.log 
    pip install $1 --upgrade 2> ${FILE} > ${FILE}
    if [ $? -eq 0 ]
    then
        echo -n "pip - installed $1 @"
        pip show $1 2> /dev/null | grep "Version:" | awk -F': ' '{print $2}'
        rm ${FILE} 2> /dev/null
    else
        echo "Error installing $1 - see ${FILE}"
    fi
}

install_python_libraries() {
    for P in \
        pip \
        virtualenv \
        ipython \
        pep8 \
        flake8 \
        jedi \
        pygments
    do
        port_install py${PY}-${P}
    done
}

ensure_log_directories_exist() {
    mkdir -p logs/pip
    rm logs/*/*.log
}

main() {
    source ${PROGDIR}/include.sh
    ensure_log_directories_exist
    check_port_variants
    install_python_libraries
}

main
