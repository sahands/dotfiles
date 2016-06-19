#!/usr/bin/env bash

# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

# Before starting anything, let's make sure XCode Command Line Utils are
# installed
xcode-select --install

# This is needed for greadlink used in a bit. So first thing let's install
# coreutils.
port install coreutils

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(greadlink -m $(dirname $0))
readonly ARGS="$@"
readonly VARIANTS_FILE="/opt/local/etc/macports/variants.conf"

function port_install {
    FILE=logs/port/${1}.log 
    port install -f $1 2> ${FILE} > ${FILE}
    if [ $? -eq 0 ]
    then
        echo -n "port - installed $1 "
        port list $1 2> /dev/null | awk -F' ' '{print $2}' 
        rm ${FILE} 2> /dev/null
    else
        echo "Error installing $1 - see ${FILE}"
    fi
}

ensure_log_directories_exist() {
    mkdir -p logs/pip
    mkdir -p logs/port
    rm logs/*/*.log
}

check_port_variants() {
    echo "Checking port variants."
    for VARIANT in bash_completion python${PY} svn ruby${RUBY} gem
    do
        grep "^+${VARIANT}$" ${VARIANTS_FILE} -q
        if [ $? -eq 1 ]
        then
            echo "Variant +${VARIANT} not found in ${VARIANTS_FILE}."
            echo "Adding it."
            sh -c 'echo "'+${VARIANT}'" >> '${VARIANTS_FILE}
        fi
    done
    echo "Active port variants:"
    cat ${VARIANTS_FILE}
}

install_python_libraries() {
    for P in \
        pip \
        virtualenv \
        ipython \
        pep8 \
        flake8 \
        jedi \
        pygments
    do
        port_install py${PY}-${P}
    done
}

select_mac_port_variants() {
    port select --set ruby ruby${RUBY}
    port select --set python python${PY}
    port select --set pip pip${PY}
    port select --set ipython ipython${PY}
    port select --set pep8 pep8${PY}
    port select --set virtualenv virtualenv${PY}
    port select --set pyflakes py${PY}-pyflakes
    port select --set py-sympy py${PY}-sympy
}

create_shortcuts() {
    echo "Creating some shortcuts..."
    rm /opt/local/bin/flake8
    rm /opt/local/bin/pygmentize
    ln -s /opt/local/bin/flake8-${PYV} /opt/local/bin/flake8
    ln -s /opt/local/bin/pygmentize-${PYV} /opt/local/bin/pygmentize
}

install_bash() {
    for P in bash bash-completion python${PY} ruby${RUBY}
    do
        port_install ${P}
    done
}

install_essentials() {
    for P in macvim git
    do
        port_install ${P}
    done
}

install_utils() {
    for P in wget grep s3cmd rlwrap screen cmake gnupg
    do
        port_install ${P}
    done
}

install_fonts() {
    echo "Installing fonts..."
    cp ../fonts/*/*.ttf /Library/Fonts/
    cp ../fonts/*/*.otf /Library/Fonts/
}

main() {
    source ${PROGDIR}/include.sh
    ensure_root

    ensure_log_directories_exist
    check_port_variants

    install_bash
    install_python_libraries
    install_essentials
    install_utils
    install_fonts

    create_shortcuts
    select_mac_port_variants
}

main
