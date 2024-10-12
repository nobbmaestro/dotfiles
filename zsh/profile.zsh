# Setup PATH
add_to_path_front $HOME/.local/bin

export EXA_COLORS="di=37;1:fi=37:ex=31:ln=35;1"

# Homebrew
if [[ "$OSTYPE" == 'darwin'* ]]; then
	add_to_path_front /opt/homebrew/bin
	add_to_path_front /opt/homebrew/sbin
elif [[ "$OSTYPE" == 'linux'* ]]; then
	add_to_path_front /home/linuxbrew/.linuxbrew/bin
fi

# Node (JS) Version Manager (JS)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

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

# CUnit
if [[ -d $(brew --prefix)/opt/cunit/include ]]; then
	C_INCLUDE_PATH=$(brew --prefix)/opt/cunit/include
	export C_INCLUDE_PATH
fi
if [[ -d $(brew --prefix)/opt/cunit/lib ]]; then
	LIBRARY_PATH=$(brew --prefix)/opt/cunit/lib
	export LIBRARY_PATH
fi

# Bob, A version manager for neovim
add_to_path_front $HOME/.local/share/bob/nvim-bin
