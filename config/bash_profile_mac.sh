# Replace vim with mvim
alias vim='mvim -v'
alias vimdiff='mvimdiff -v'

# mvim instead of vim
export EDITOR="mvim -v"

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

# Use GNU core utils instead of Mac OS X ones
# export PATH=/opt/local/libexec/gnubin:$PATH
# alias ls='gls --color=auto'

# Run duti with ~/.duti file as settings
# On second thought, let's run this manually when needed
# duti ~/.duti

# Set up gulp bash completion
# Disabling for now
# eval "$(gulp --completion=bash)"
