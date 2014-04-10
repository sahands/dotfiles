#!/usr/bin/env bash

# Version of Python to use
PY=27
PYV="2.7"
VARIANTS_FILE="/opt/local/etc/macports/variants.conf"

SCRIPT_DIR=`dirname $0`
source $SCRIPT_DIR/include.sh

ensure_root

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
rm logs/*/*.log


# Install HR
echo "Installing hr..."
cd utils/hr
make install > /dev/null 2> /dev/null
cd ../..


# Update port
# port selfupdate

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


for P in pip ipython numpy matplotlib pep8 flake8 jedi scikit-learn scipy nltk pymongo virtualenv pygments zmq
do
    port_install py${PY}-$P
done

# Select port's python
hr
port select --set python python${PY}
port select --set pip pip${PY}
port select --set ipython ipython${PY}
port select --set pep8 pep8${PY}
port select --set virtualenv virtualenv${PY}
port select --set pyflakes py${PY}-pyflakes

echo "Creating some shortcuts..."
ln -s /opt/local/bin/flake8-${PYV} /opt/local/bin/flake8
ln -s /opt/local/bin/pygmentize-${PYV} /opt/local/bin/pygmentize
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


# pip installs
for P in pelican
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
