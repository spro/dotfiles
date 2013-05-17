ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"
# (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(autojump zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# The dotfiles
source $HOME/.env
source $HOME/.paths
source $HOME/.aliases

# Vim bindings
bindkey -v
