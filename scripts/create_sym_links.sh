#!/usr/bin/env bash

BACKUP=NO
PLATFORM=`uname`
if [[ "$PLATFORM" == 'Darwin' ]]; then
echo "HERE"
    SCRIPT=`greadlink -f $0`
    SCRIPTPATH=`dirname $SCRIPT`
    CONFIGPATH=`greadlink -f $SCRIPTPATH/../config`
else
    SCRIPT=`readlink -f $0`
    SCRIPTPATH=`dirname $SCRIPT`
    CONFIGPATH=`readlink -f $SCRIPTPATH/../config`
fi

for FILE in $CONFIGPATH/*
do
    BASEFILE=$(basename "$FILE")
    CONFFILE=${BASEFILE%.*}
    echo "~/.$CONFFILE -> $FILE"
    if [ -L ~/.$CONFFILE ] || [ -e ~/.$CONFFILE ]
    then
        if [ $BACKUP == 'YES' ]
        then
            echo "WARNING - ~/.$CONFFILE already exists. Renaming to ~/.$CONFFILE.old"
            mv ~/.$CONFFILE ~/.$CONFFILE.old
        else
            echo "WARNING - ~/.$CONFFILE already exists. Deleting it." 
            rm ~/.$CONFFILE
        fi
    fi
    ln -s $CONFIGPATH/$BASEFILE ~/.$CONFFILE
done
