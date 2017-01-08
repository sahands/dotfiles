# Use vim anytime an editor is needed by bash
export EDITOR="vim"

# Use vi keyboard shortcuts in bash
set -o vi

export HISTSIZE=100000
export HISTCONTROL=ignoreboth:erasedups  # avoid duplicates
export HISTIGNORE="&:ls:exit"            # ignore ls calls and exit
shopt -s no_empty_cmd_completion         # Don't tab-complete if prompt is empty
shopt -s histappend                      # Append to the Bash history file
shopt -s cdspell                         # Correct typos in paths for `cd`

# History completion to what's already on the line
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# The following two are Bash 4 features
VERSION=( ${BASH_VERSION//./ } ) 
if [ ${VERSION[0]} -eq "4" ]
then
    # `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
    shopt -s autocd
    # Recursive globbing, e.g. `echo **/*.txt`
    shopt -s globstar
fi

# Set the prompt
PS1="[\\A] \\w $ "  # Time followed by current directory
# PS1="[\!] \\w \$ "  # Current command history number followed by current directory

# Include bashrc if it exists
if [ -e ~/.bashrc ] || [ -L ~/.bashrc ]; then
    source ~/.bashrc
fi

# Include aliases file if it exits
if [ -e ~/.bash_aliases ] || [ -L ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Load Mac specific settings if on a Mac
PLATFORM=`uname`
if [[ "$PLATFORM" == 'Darwin' ]]; then
    source ~/.bash_profile_mac
fi
