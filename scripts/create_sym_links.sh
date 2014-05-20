#!/usr/bin/env bash

SCRIPT=`greadlink -f $0`
SCRIPTPATH=`dirname $SCRIPT`
CONFIGPATH=`greadlink -f $SCRIPTPATH/../config`
BACKUP=NO

for FILE in $CONFIGPATH/*
do
    BASEFILE=$(basename "$FILE")
    CONF_FILE=${BASEFILE%.*}
    echo "~/.$CONF_FILE -> $FILE"
    if [ -L ~/.$CONF_FILE ] || [ -e ~/.$CONF_FILE ]
    then
        if [ $BACKUP == 'YES' ]
        then
            echo "WARNING - ~/.$CONF_FILE already exists. Renaming to ~/.$CONF_FILE.old"
            mv ~/.$CONF_FILE ~/.$CONF_FILE.old
        else
            echo "WARNING - ~/.$CONF_FILE already exists. Deleting it." 
            rm ~/.$CONF_FILE
        fi
    fi
    ln -s $SCRIPTPATH/$FILE ~/.$CONF_FILE
done
