if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
    source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"
end

set EDITOR vim

set fish_greeting # Set to empty

# Paths
# -----

fish_add_path ~/.bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path ~/.bun/bin
fish_add_path /opt/homebrew/opt/ruby/bin

set -x FZF_DEFAULT_COMMAND 'ag -g ""'

# Key bindings
# ------------

bind -M insert \cP history-token-search-backward
bind -M insert \cN history-token-search-forward

# Aliases
# -------

# Ls related

alias l="eza"
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias lr="eza -lar"
alias lar="eza -lar"
alias ltr="eza -lar -sold"

# Editor related

alias vim="nvim"
alias c="cursor ."
alias ws="windsurf ."

# Git related

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

# Python related

alias uvp='uv run python'
alias uvi='uv run ipython -i'

# Etc

alias ytdl='yt-dlp_macos -x --audio-format wav'
alias yaegi='rlwrap ~/go/bin/yaegi'

# Functions
# ---------

# Find a ranked list of files with the given string
function with
    ag -c $argv[1] | awk -F: '{print $2, $1}' | sort -nr | awk '{print "\033[32m" $1 "\033[0m", $2}'
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

# Get ports used by processes
function ports
    if test (count $argv) -eq 0
        echo "Listing all listening ports..."
        sudo lsof -nP -iTCP -sTCP:LISTEN | \
            awk '{printf "%-10s %-6s %-6s %-20s %-10s %s\n", $1, $2, $3, $9, $8, $NF}'
    else
        set port $argv[1]
        echo "Looking for processes using port $port..."
        sudo lsof -nP -iTCP:$port -sTCP:LISTEN | \
            awk '{printf "%-10s %-6s %-6s %-20s %-10s %s\n", $1, $2, $3, $9, $8, $NF}'
    end
end

# Abbreviations
# -------------

function last_history_item
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

# Prompt
# ------

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

# External programs etc
# ---------------------

# zoxide
zoxide init fish | source
alias j=z

# Direnv
direnv hook fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/Users/sean/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /opt/homebrew/anaconda3/bin/conda
#     eval /opt/homebrew/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# else
#     if test -f "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
#         . "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH "/opt/homebrew/anaconda3/bin" $PATH
#     end
# end
# # <<< conda initialize <<<


# Added by Windsurf
fish_add_path /Users/sean/.codeium/windsurf/bin
