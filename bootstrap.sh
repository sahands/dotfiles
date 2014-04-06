#!/usr/bin/env bash

# Version of Python to use
PY=27
VARIANTS_FILE="/opt/local/etc/macports/variants.conf"

# Make sure it's run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Trap Control + C and exit the whole script
trap ctrl_c INT

function ctrl_c() {
    echo
    echo "User interrupt. Exiting"
    exit
}


# Pull all git submodules
git submodule foreach git pull -q origin master > /dev/null


# Make sure logs dirs are there
mkdir -p logs/pip
mkdir -p logs/port


# Install HR
echo "Installing hr..."
cd utils/hr
make install > /dev/null 2> /dev/null
cd ../..

# Functions to install port and pip packages

function port_install {
    FILE=logs/port/${1}.log 
    port install $1 2> $FILE > $FILE
    if [ $? -eq 0 ]
    then
        echo -n "port - installed $1 "
        port list $1 2> /dev/null | awk -F' ' '{print $2}' 
        rm $FILE 2> /dev/null
    else
        echo "Error installing $1 - see $FILE"
    fi
}

function pip_install {
    FILE=logs/pip/${1}.log 
    pip install $1 --upgrade 2> $FILE > $FILE
    if [ $? -eq 0 ]
    then
        echo -n "pip - installed $1 @"
        pip show $1 2> /dev/null | grep "Version:" | awk -F': ' '{print $2}'
        rm $FILE 2> /dev/null
    else
        echo "Error installing $1 - see $FILE"
    fi
}


# Update port
port selfupdate

# Install bash and zsh

for P in bash bash-completion zsh zsh-completions python${PY} 
do
    port_install $P
done

# Replace default bash with latest version of bash
mv /bin/bash /bin/bash-old
ln -s /opt/local/bin/bash /bin/bash


hr
echo "Checking port variants."
for VARIANT in bash_completion zsh_completion python${PY} svn
do
    grep "^+$VARIANT$" $VARIANTS_FILE -q
    if [ $? -eq 1 ]
    then
        echo "Variant +$VARIANT not found in $VARIANTS_FILE."
        echo "Adding it."
        sh -c 'echo "'+$VARIANT'" >> '$VARIANTS_FILE
    fi
done
echo "Active port variants:"
cat $VARIANTS_FILE
hr


for P in pip ipython numpy matplotlib pep8 flake8 jedi scikit-learn scipy
do
    port_install py${PY}-$P
done

# Select port's python
hr
port select --set python python${PY}
port select --set pip pip${PY}
port select --set ipython ipython${PY}
hr

# Essentials
for P in macvim git-core mercurial
do
    port_install $P
done


# Utils
for P in wget sudo grep man coreutils ispell s3cmd mongodb rlwrap screen
do
    port_install $P
done

# Latex
for P in texlive texlive-basic texlive-bibtex-extra texlive-bin texlive-bin texlive-bin-extra texlive-common texlive-context texlive-fonts-recommended texlive-fonts-extra texlive-fontutils texlive-generic-recommended texlive-lang-english texlive-latex texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-math-extra texlive-metapost texlive-pictures texlive-plain-extra texlive-pstricks texlive-science texlive-xetex
do
    port_install $P
done


# pip installs
for P in pelican pep8 flake8 jedi pymongo nltk
do
    pip_install $P
done


# Install duti
echo "Installing duti..."
cd utils/duti
autoconf ./configure.ac > configure 2> /dev/null
chmod +x configure > /dev/null 2> /dev/null
./configure > /dev/null 2> /dev/null
make > /dev/null 2> /dev/null
make install > /dev/null 2> /dev/null
make clean > /dev/null 2> /dev/null
cd ../..
