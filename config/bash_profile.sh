# Use vim anytime an editor is needed by bash
export EDITOR="vim"

# Load Mac specific settings if on a Mac
PLATFORM=`uname`
if [[ "$PLATFORM" == 'Darwin' ]]; then
    source ~/.bash_profile_mac
fi

# Use vi keyboard shortcuts in bash
set -o vi

# bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

# Better history
export HISTSIZE=100000
export HISTCONTROL=ignoreboth:erasedups   # avoid duplicates
export HISTIGNORE="&:ls:exit"             # ignore ls calls and exit
shopt -s no_empty_cmd_completion          # Don't tab-complete if prompt is empty

# History completion to what's already on the line
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
shopt -s autocd

# Recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar

# Set the prompt
PS1="[\\A] \\w $ "

# Include bashrc if it exists
if [ -e ~/.bashrc ] || [ -L ~/.bashrc ]; then
    source ~/.bashrc
fi
