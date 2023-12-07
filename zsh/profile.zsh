# Setup PATH
add_to_path_front $HOME/.local/bin
add_to_path_front /usr/local/bin/
add_to_path_front /usr/local/sbin/

# Homebrew
if [[ "$OSTYPE" == 'darwin'* ]]; then
	add_to_path_front /opt/homebrew/bin
elif [[ "$OSTYPE" == 'linux'* ]]; then
	add_to_path_front /home/linuxbrew/.linuxbrew/bin
fi

if (type "brew" >/dev/null 2>&1); then
	eval $($(brew --prefix)/bin/brew shellenv)
fi

# Source shell packages
source_if_exists $ZSH/oh-my-zsh.sh

# Source zsh plugins
source_if_exists $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source_if_exists $(brew --prefix)/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source_if_exists $(brew --prefix)/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Node (JS) Version Manager (JS)
if type "nvm" >/dev/null 2>&1; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
	alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"
fi

# Python Version Manager
if type "pyenv" >/dev/null 2>&1; then
	export PYENV_ROOT="$HOME/.pyenv"
	add_to_path $PYENV_ROOT/bin
	eval "$(pyenv init -)"
fi

# Python: Set up direnv hook (for activating local dir venv)
if type "direnv" >/dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

# Ruby Version Manager
if type "rbenv" >/dev/null 2>&1; then
	eval "$(rbenv init - zsh)"
fi

# Zoxide
if type "zoxide" >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
fi

# CUnit
if [[ -d $(brew --prefix)/opt/cunit/include ]]; then
	C_INCLUDE_PATH=$(brew --prefix)/opt/cunit/include
	export C_INCLUDE_PATH
fi
if [[ -d $(brew --prefix)/opt/cunit/lib ]]; then
	LIBRARY_PATH=$(brew --prefix)/opt/cunit/lib
	export LIBRARY_PATH
fi
