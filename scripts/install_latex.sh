#!/usr/bin/env bash

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

    port_install texlive

    for P in basic bibtex-extra bin bin bin-extra common context fonts-recommended fonts-extra fontutils generic-recommended lang-english latex latex-extra latex-recommended luatex math-extra metapost pictures plain-extra pstricks science xetex
    do
        port_install texlive-$P
    done
}

main
