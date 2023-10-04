# Setup PATH
add_to_path_front /opt/homebrew/bin
add_to_path_front $HOME/.local/bin
add_to_path_front /usr/local/bin/
add_to_path_front /usr/local/sbin/
add_to_path /opt/homebrew/opt/ruby/bin
add_to_path /opt/homebrew/opt/ruby@2.7/bin

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)
 
# Source shell packages
source_if_exists $ZSH/oh-my-zsh.sh

# Other
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# Python
eval "$(pyenv init -)"
export PYENV_ROOT="$HOME/.pyenv" 
add_to_path $PYENV_ROOT/bin
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# Set up direnv hook (for activating local dir venv)
eval "$(direnv hook zsh)"
