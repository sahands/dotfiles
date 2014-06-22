#!/usr/bin/env bash

# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

# Version of Python to use
readonly PY=27
readonly PYV="2.7"
readonly RUBY=19
readonly RUBYV="1.9.2"
readonly VARIANTS_FILE="/opt/local/etc/macports/variants.conf"

# Functions to install port and pip packages
function port_install {
    FILE=logs/port/${1}.log 
    port install $1 2> ${FILE} > ${FILE}
    if [ $? -eq 0 ]
    then
        echo -n "port - installed $1 "
        port list $1 2> /dev/null | awk -F' ' '{print $2}' 
        rm ${FILE} 2> /dev/null
    else
        echo "Error installing $1 - see ${FILE}"
    fi
}

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

function ensure_root {
    # Make sure it's run as root
    if [[ ${EUID} -ne 0 ]]; then
       echo "This script must be run as root" 1>&2
       exit 1
    fi
}

# Trap Control + C and exit the whole script
trap ctrl_c INT

function ctrl_c() {
    echo
    echo "User interrupt. Exiting"
    exit
}

ensure_root
