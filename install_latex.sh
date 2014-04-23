#!/usr/bin/env bash

SCRIPT_DIR=`dirname $0`
source $SCRIPT_DIR/include.sh

port_install texlive

for P in basic bibtex-extra bin bin bin-extra common context fonts-recommended fonts-extra fontutils generic-recommended lang-english latex latex-extra latex-recommended luatex math-extra metapost pictures plain-extra pstricks science xetex
do
    port_install texlive-$P
done
