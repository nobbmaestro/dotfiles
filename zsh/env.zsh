# Configuration directories
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$HOME/.config/zsh"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Editor Configuration
export EDITOR="nvim"
export VISUAL="nvim"

# Bob, A version manager for neovim
add_to_path_front $HOME/.local/share/bob/nvim-bin

# Homebrew paths
if [[ "$OSTYPE" == 'darwin'* ]]; then
	add_to_path_front /opt/homebrew/bin
	add_to_path_front /opt/homebrew/sbin
elif [[ "$OSTYPE" == 'linux'* ]]; then
	add_to_path_front /home/linuxbrew/.linuxbrew/bin
fi

# Python Version Manager
if type "pyenv" >/dev/null 2>&1; then
	export PYENV_ROOT="$HOME/.pyenv"
	add_to_path_front $PYENV_ROOT/bin
	eval "$(pyenv init -)"
fi

# Python: Set up direnv hook (for activating local dir venv)
#   pipenv:   echo layout pipenv >> .envrc
#   other:    echo 'source $(pwd)/.venv/bin/activate' >> .envrc
if type "direnv" >/dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

# Node (JS) Version Manager (JS)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Ruby Version Manager
if type "rbenv" >/dev/null 2>&1; then
	if [[ ! "$PATH" != *"$1"* ]]; then
		eval "$(rbenv init - zsh)"
	fi
fi

# Zoxide
if type "zoxide" >/dev/null 2>&1; then
	eval "$(zoxide init --cmd cd zsh)"
fi
