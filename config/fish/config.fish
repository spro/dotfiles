if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
    source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"
end

set EDITOR vim

set fish_greeting

fish_add_path ~/.bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path ~/.bun/bin
fish_add_path /opt/homebrew/opt/ruby/bin

function watchand
    set -l dir $argv[1]
    set -l cmd (string join " " $argv[2..-1])
    clear; eval $cmd; fswatch -o src | while read -d "" event; clear; eval $cmd; end
end

set -x FZF_DEFAULT_COMMAND 'ag -g ""'

# Bindings

bind -M insert \cP history-token-search-backward
bind -M insert \cN history-token-search-forward

# Aliases and custom functions
# ------

alias l="eza"
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias lr="eza -lar"
alias lar="eza -lar"
alias ltr="eza -lar -sold"

alias vim="nvim"
alias c="cursor ."
alias ws="windsurf ."

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gd="git diff"
alias gb="git checkout -b"
alias gp="git push"

alias gtree="fd --type f --hidden --exclude .git | tree --fromfile"

alias gssh="gcloud compute ssh"
alias gscp="gcloud compute scp"

alias branches='git for-each-ref --sort=-committerdate refs/heads/ --format="%(color:red)%(committerdate:short)%(color:reset) %(refname:short)" --color always'

alias docker-compose='docker compose'

alias uvp='uv run python'
alias uvi='uv run ipython -i'

alias vc='/Users/sean/Library/Application\ Support/Steam/steamapps/common/Valheim/Valheim.app/Contents/MacOS/Valheim -console'

alias ytdl='yt-dlp_macos -x --audio-format wav'

alias yaegi='rlwrap ~/go/bin/yaegi'

# Find a ranked list of files with the given string
function with
    ag -c $argv[1] | awk -F: '{print $2, $1}' | sort -nr | awk '{print "\033[32m" $1 "\033[0m", $2}'
end

function useenv
    for line in (cat .env | grep -v '^#' | grep -v '^\s*$')
        set item (string split -m 1 '=' $line)
        set -gx $item[1] $item[2]
        echo "Exported key $item[1]"
    end
end


# Start a new tmux session
function tx
    set dirname (basename $PWD | sed 's/[^[a-z0-9-]/-/g')
    tmux new -s $dirname || tmux a -t $dirname
end

# Create a directory and start a tmux session in it
function mx
    mkdir -p $argv[1]
    cd $argv[1]
    tx
end

# Abbreviations

function last_history_item
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

# Hydro (prompt theme) customization

set hydro_color_pwd blue
set hydro_color_git green
set fish_color_selection green

# Vim mode prompt

function not_fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo 'N'
        case insert
            set_color --bold green
            echo 'I'
        case replace_one
            set_color --bold green
            echo 'R'
        case visual
            set_color --bold brmagenta
            echo 'V'
        case '*'
            set_color --bold red
            echo '?'
    end
    echo ' '
    set_color normal
end
