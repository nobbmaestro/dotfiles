# User configuration
source $ZDOTDIR/functions.zsh
source_if_exists $ZDOTDIR/profile.zsh
source_if_exists $ZDOTDIR/aliases.zsh
source_if_exists $ZDOTDIR/history.zsh
source_if_exists $HOME/repos/dotfiles/zsh/profile_work.zsh

# Language settings
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch arm64"

# Source zsh plugins
source_if_exists $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source_if_exists $(brew --prefix)/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source_if_exists $(brew --prefix)/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship prompt
if type "starship" >/dev/null 2>&1; then
	eval "$(starship init zsh)"
fi

# Fzf integration
if type "fzf" >/dev/null 2>&1; then
	# zsh-vi-mode interferes with fzf-history-widget bindkey
	# https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#execute-extra-commands
	if type "zvm_version" >/dev/null 2>&1; then
		zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
	else
		source_if_exists $HOME/.fzf.zsh
	fi
fi

# Zoxide
if type "zoxide" >/dev/null 2>&1; then
	eval "$(zoxide init --cmd cd zsh)"
fi

# Python: Set up direnv hook (for activating local dir venv)
#   pipenv:   echo layout pipenv >> .envrc
#   other:    echo 'source $(pwd)/.venv/bin/activate' >> .envrc
if type "direnv" >/dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

# Python Version Manager
if type "pyenv" >/dev/null 2>&1; then
	export PYENV_ROOT="$HOME/.pyenv"
	add_to_path_front $PYENV_ROOT/bin
	eval "$(pyenv init -)"
fi

# Node (JS) Version Manager (JS)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
