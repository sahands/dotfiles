#!/usr/bin/env bash

# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

if [[ `uname` == 'Darwin' ]]; then
    readonly PROGNAME=$(basename $0)
    readonly PROGDIR=$(greadlink -m $(dirname $0))
    readonly CONFIGPATH=`greadlink -f $PROGDIR/../config`
else
    readonly PROGNAME=$(basename $0)
    readonly PROGDIR=$(readlink -m $(dirname $0))
    readonly CONFIGPATH=`readlink -f $PROGDIR/../config`
fi

# Options
readonly BACKUP="YES"

main() {
    for FILE in ${CONFIGPATH}/*
    do
        BASEFILE=$(basename "$FILE")
        CONFFILE=${BASEFILE%.*}
        echo "~/.${CONFFILE} -> ${FILE}"
        if [ -L ~/.${CONFFILE} ] || [ -e ~/.${CONFFILE} ]
        then
            if [ ${BACKUP} == "YES" ]
            then
                echo "WARNING - ~/.${CONFFILE} already exists. Renaming to ~/.${CONFFILE}.old"
                mv ~/.${CONFFILE} ~/.${CONFFILE}.old
            else
                echo "WARNING - ~/.$CONFFILE already exists. Deleting it." 
                rm ~/.$CONFFILE
            fi
        fi
        ln -s ${CONFIGPATH}/${BASEFILE} ~/.${CONFFILE}
    done
}

main