ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spro"
# (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(autojump zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# The dotfiles
source $HOME/.env
source $HOME/.paths
source $HOME/.aliases

bindkey -v # Use vim bindings
bindkey '^R' history-incremental-search-backward # But keep <C>-R
