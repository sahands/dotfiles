#!/bin/bash

# Version of Python to use
PY=27

VARIANTS_FILE="/opt/local/etc/macports/variants.conf"

# Trap Control + C and exit the whole script
trap ctrl_c INT

function ctrl_c() {
    echo
    echo "User interrupt. Exiting"
    exit
}

# Make sure logs dirs are there
mkdir -p logs/pip
mkdir -p logs/port


function port_install {
    FILE=logs/port/${1}.log 
    sudo port install $1 2> $FILE > $FILE
    if [ $? -eq 0 ]
    then
        echo -n "port - installed $1 "
        sudo port list $1 2> /dev/null | awk -F' ' '{print $2}' 
        rm $FILE 2> /dev/null
    else
        echo "Error installing $1 - see $FILE"
    fi
}

function pip_install {
    FILE=logs/pip/${1}.log 
    sudo pip install $1 --upgrade 2> $FILE > $FILE
    if [ $? -eq 0 ]
    then
        echo -n "pip - installed $1 @"
        sudo pip show $1 2> /dev/null | grep "Version:" | awk -F': ' '{print $2}'
        rm $FILE 2> /dev/null
    else
        echo "Error installing $1 - see $FILE"
    fi
}


for P in bash bash-completion zsh zsh-completions python${PY} 
do
    port_install $P
done

# Replace default bash with latest version of bash
sudo mv /bin/bash /bin/bash-old
sudo ln -s /bin/bash /opt/local/bin/bash


./hr
echo "Checking port variants."
for VARIANT in bash_completion zsh_completion python${PY} svn
do
    grep "^+$VARIANT$" $VARIANTS_FILE -q
    if [ $? -eq 1 ]
    then
        echo "Variant +$VARIANT not found in $VARIANTS_FILE."
        echo "Adding it."
        # bash -C '\''sudo echo'$VARIANT'>>'$VARIANTS_FILE\'
        # echo "'"'echo "'+$VARIANT'" >> '$VARIANTS_FILE"'"
        sudo sh -c 'echo "'+$VARIANT'" >> '$VARIANTS_FILE
    fi
done
echo "Active port variants:"
sudo cat $VARIANTS_FILE
./hr


for P in pip ipython numpy matplotlib pep8 flake8 jedi pandas scikit-learn scipy zmq
do
    port_install py${PY}-$P
done

# Select port's python
./hr
sudo port select --set python python${PY}
sudo port select --set pip pip${PY}
sudo port select --set ipython ipython${PY}
./hr

# Essentials
for P in macvim git-core mercurial
do
    port_install $P
done


# Utils
for P in wget sudo grep man coreutils ispell s3cmd mongodb rlwrap openssl
do
    port_install $P
done

# Latex
for P in texlive texlive-basic texlive-bibtex-extra texlive-bin texlive-bin texlive-bin-extra texlive-common texlive-context texlive-fonts-recommended texlive-fonts-extra texlive-fontutils texlive-generic-recommended texlive-lang-english texlive-latex texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-math-extra texlive-metapost texlive-pictures texlive-plain-extra texlive-pstricks texlive-science texlive-xetex
do
    port_install $P
done


# pip installs
for P in pelican pep8 flake8 jedi pymongo nltk vincent
do
    pip_install $P
done


# Install duti
cd utils/duti
./configure
make
sudo make install
make clean
cd ../..

