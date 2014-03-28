# Use vim anytime an editor is needed by bash
export EDITOR="mvim -v"

# Replace vim with mvim
alias vim='mvim -v'

# Use vi keyboard shortcuts in bash 
# (for example, Escape then j will move the cursor one left in Terminal)
set -o vi

# Enable colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### AWS RDS toolbelt related variables
export AWS_RDS_HOME="/usr/local/amazonrds"
export JAVA_HOME="/Library/Java/Home"
export PATH="${AWS_RDS_HOME}/bin:$PATH"


# MacPorts Installer addition on 2013-08-31_at_18:02:08: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Add the /opt python bin directory to path
# export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.3/bin/:$PATH

# bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

# Better history
export HISTSIZE=100000
export HISTCONTROL=ignoreboth:erasedups # avoid duplicates
export HISTIGNORE="&:ls:exit"           # ignore ls calls and exit
shopt -s no_empty_cmd_completion        # Don't tab-complete if prompt is empty

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

# https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
# Set the prompt
# BLUE=$(tput setaf 27)
# PINK=$(tput setaf 224)
# LIGHTBLUE=$(tput setaf 159)

PS1="[\\A] \\w $ "

# Run duti with ~/.duti file as settings
duti ~/.duti
