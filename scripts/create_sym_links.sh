#!/usr/bin/env bash

SCRIPT=`readlink -f $0`
SCRIPTPATH=`dirname $SCRIPT`
BACKUP=NO

PLATFORM=`uname`
if [[ "$PLATFORM" == 'Darwin' ]]; then
    CONFIGPATH=`greadlink -f $SCRIPTPATH/../config`
else
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
