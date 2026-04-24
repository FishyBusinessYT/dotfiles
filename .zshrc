ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
OMP_PATH="${HOME}/.local/bin/oh-my-posh"
export PATH=$PATH:/home/cris/.local/bin

#Zoxide install in case its not present yet
if ! command -v zoxide &> /dev/null; then
    echo "Zoxide not installed. Installing..."
    sudo pacman -S --noconfirm zoxide
fi

#fzf install in case its not present yet
if ! command -v fzf &> /dev/null; then
    echo "fzf not installed. Installing..."
    sudo pacman -S --noconfirm fzf
fi

#Oh my posh install in case its not present yet
if [ ! -e "$OMP_PATH" ]; then
    echo "Oh-my-posh not installed on ${OMP_PATH}. Installing..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

#Zinit install in case its not present yet
if [ ! -d "$ZINIT_HOME" ]; then
    echo "Zinit not installed. Installing..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

#Zinit initialization
source "${ZINIT_HOME}/zinit.zsh"

#Oh-my-posh initialization
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/prompt-theme.toml)"

#Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

#Completions
autoload -U compinit && compinit # Load completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Completions case-insensitive

#History settings
HISTSIZE=10000 # Number of commands to save
HISTFILE=~/.zsh_history # Where to save said commands
SAVEHIST=$HISTSIZE # How many commands to save to the disk
HISTDUP=erase #Erase duplicate commands from the history
setopt appendhistory # Append new commands to the end of the file
setopt sharehistory # Share history between sessions
setopt hist_ignore_space # Don't save commands that start with a space (to hide certain commands from the history)

#Prevent duplicate entries from being stored in the history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

#Custom aliases
alias ll='ls -lAh --color=auto'
alias supd='sudo dnf update'
alias code='code . -n'
alias aseprite='/home/cris/Documents/repositories/aseprite/build/bin/aseprite'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "(percentage|state|time to empty)"'
alias godot='godot --single-window -e'
alias ff='fastfetch'
alias activate='source venv/bin/activate &> /dev/null || source .venv/bin/activate &> /dev/null'
alias c='clear'

#Git
alias ga='git add'
alias gcm='git commit'
alias gps='git push'
alias gpl='git pull'
alias gst='git status'
alias gd='git diff'
alias gl='git log --graph --oneline --all --decorate'
alias gs='git switch'
alias gf='git fetch'

#Dotfiles management
alias dots='/usr/bin/git --work-tree=$HOME --git-dir=$HOME/.dotfiles'
alias dotsa='dots add'
alias dotscm='dots commit'
alias dotsps='dots push'
alias dotspl='dots pull'
alias dotst='dots status'
alias dotsd='dots diff'
alias dotsl='dots log --graph --oneline --all --decorate'
alias dotsw='dots switch'
alias dotsf='dots fetch'

#Custom bindings
bindkey "^n" history-beginning-search-forward
bindkey "^p" history-beginning-search-backward

bindkey "^[[H" beginning-of-line # Make Home key work
bindkey "^[[F" end-of-line # Make End key work
bindkey "^[[3~" delete-char # Make Del key work

bindkey "^[[1;5D" backward-word #Ctrl-left to go back one word
bindkey "^[[1;5C" forward-word #Ctrl-right to go forward one word
bindkey "^[[3;3~" kill-word # Make Alt+Del delete the next word

#Fuzzy finder and Zoxide (better cd command)
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
