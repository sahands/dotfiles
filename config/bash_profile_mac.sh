# Replace vim with mvim
alias vim='mvim -v'
alias vimdiff='mvimdiff -v'

# mvim instead of vim
export EDITOR="mvim -v"

# Use Homebrew bash instead of /bin/bash
export SHELL="/usr/local/bin/bash"
export BASH="/usr/local/bin/bash"

# Enable colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

### AWS RDS toolbelt related variables
export AWS_RDS_HOME="/usr/local/amazonrds"
export JAVA_HOME="/Library/Java/Home"
export PATH="${AWS_RDS_HOME}/bin:$PATH"

# Homebrew bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
