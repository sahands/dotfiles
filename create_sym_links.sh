#!/opt/local/bin/bash

SCRIPT=`greadlink -f $0`
SCRIPTPATH=`dirname $SCRIPT`
BACKUP=NO

for FILE in dotfiles/*
do
    BASEFILE=$(basename "$FILE")
    CONF_FILE=${BASEFILE%.*}
    echo "Creating symbolic link ~/.$CONF_FILE to $FILE"
    if [ -e ~/.$f ]
    then
        if [ $BACKUP == "YES" ] 
        then
            echo " - ~/.$CONF_FILE already exists. Renaming to ~/.$CONF_FILE.old"
            mv ~/.$CONF_FILE ~/.$CONF_FILE.old
        else
            rm ~/.$CONF_FILE
        fi
    fi
    ln -s $SCRIPTPATH/$FILE ~/.$CONF_FILE
done
