# Configuration directories
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$HOME/.config/zsh"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Editor Configuration
export EDITOR="nvim"
export VISUAL="nvim"

# Source helpers
source $ZDOTDIR/functions.zsh

# Bob, A version manager for neovim
add_to_path_front $HOME/.local/share/bob/nvim-bin

# Homebrew paths
if [[ "$OSTYPE" == 'darwin'* ]]; then
	add_to_path_front /opt/homebrew/bin
	add_to_path_front /opt/homebrew/sbin
elif [[ "$OSTYPE" == 'linux'* ]]; then
	add_to_path_front /home/linuxbrew/.linuxbrew/bin
fi

# Ruby Version Manager
if type "rbenv" >/dev/null 2>&1; then
	if [[ ! "$PATH" != *"$1"* ]]; then
		eval "$(rbenv init - zsh)"
	fi
fi
