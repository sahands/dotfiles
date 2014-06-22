#!/usr/bin/env bash

# Use "strict" mode
set -u
set -o pipefail
IFS=$'\n\t'

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(greadlink -m $(dirname $0))
readonly ARGS="$@"

ensure_log_directories_exist() {
    mkdir -p logs/pip
    mkdir -p logs/port
    rm logs/*/*.log
}

install_hr() {
    echo "Installing hr..."
    pushd ../utils/hr
    make install > /dev/null 2> /dev/null
    popd
}

check_port_variants() {
    hr
    echo "Checking port variants."
    for VARIANT in bash_completion zsh_completion python${PY} svn ruby${RUBY} gem
    do
        grep "^+${VARIANT$}" ${VARIANTS_FILE} -q
        if [ $? -eq 1 ]
        then
            echo "Variant +${VARIANT} not found in ${VARIANTS_FILE}."
            echo "Adding it."
            sh -c 'echo "'+${VARIANT}'" >> '${VARIANTS_FILE}
        fi
    done
    echo "Active port variants:"
    cat ${VARIANTS_FILE}
    hr
}

select_mac_port_variants() {
    hr
    port select --set ruby ruby${RUBY}
    port select --set python python${PY}
    port select --set pip pip${PY}
    port select --set ipython ipython${PY}
    port select --set pep8 pep8${PY}
    port select --set virtualenv virtualenv${PY}
    port select --set pyflakes py${PY}-pyflakes
    port select --set py-sympy py${PY}-sympy
    hr
}

create_shortcuts() {
    echo "Creating some shortcuts..."
    ln -s /opt/local/bin/flake8-${PYV} /opt/local/bin/flake8
    ln -s /opt/local/bin/pygmentize-${PYV} /opt/local/bin/pygmentize
    hr
}

install_bash() {
    for P in bash bash-completion zsh zsh-completions python${PY} ruby${RUBY}
    do
        port_install ${P}
    done
    hr
}

install_python_libraries() {
    for P in pip virtualenv ipython scipy numpy sympy pandas matplotlib scikit-learn nltk pep8 flake8 jedi pymongo pygments zmq nose tz
    do
        port_install py${PY}-${P}
    done
    hr
}

install_essentials() {
    for P in macvim git-core mercurial
    do
        port_install ${P}
    done
    hr
}

install_utils() {
    for P in wget sudo grep man coreutils ispell s3cmd mongodb rlwrap screen cmake ctags pdf2svg ImageMagick gnupgp
    do
        port_install ${P}
    done
    hr
}

install_duti() {
    echo "Installing duti..."
    pushd ../utils/duti
    autoconf ./configure.ac > configure 2> /dev/null
    chmod +x configure > /dev/null 2> /dev/null
    ./configure > /dev/null 2> /dev/null
    make > /dev/null 2> /dev/null
    make install > /dev/null 2> /dev/null
    make clean > /dev/null 2> /dev/null
    popd
}

install_fonts() {
    echo "Installing fonts..."
    cp ../fonts/*/*.ttf /Library/Fonts/
    cp ../fonts/*/*.otf /Library/Fonts/
}

main() {
    source ${PROGDIR}/include.sh
    ensure_log_directories_exist
    install_hr
    install_bash
    check_port_variants
    install_python_libraries
    select_mac_port_variants
    create_shortcuts
    install_essentials
    install_utils
    install_duti
    install_fonts
}

main
