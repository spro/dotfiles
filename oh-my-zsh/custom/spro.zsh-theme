function print_dir() {
    if [ "$(pwd)" != $HOME ]; then
        echo ${$(dirname "$(pwd)")/$HOME/\~}/
    fi
}

function print_file() {
    if [ "$(pwd)" != $HOME ]; then
        basename "$(pwd)"
    else
        echo "~"
    fi
}

local caret_char=">"
local caret="%(?:%{$fg_bold[green]%}${caret_char}:%{$fg_bold[red]%}${caret_char})"

PROMPT='%{$FG[245]%}[%t] %{$fg[blue]%}$(print_dir)%U$(print_file)%u $(git_prompt_info)${caret} %{$reset_color%}'

MODE_INDICATOR="%{$fg[green]%}...%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[yellow]%}* "
ZSH_THEME_GIT_PROMPT_CLEAN=" "
