export PS1="\[\e[0;35m\]\u@\H:\[\e[m\] \[\e[4;34m\]\w\[\e[m\] \[\e[0;32m\]>\[\e[m\] "

# The dotfiles
source $HOME/.env
source $HOME/.paths
source $HOME/.aliases

# Vim bindings
set -o vi

alias ls='ls --color=auto'
