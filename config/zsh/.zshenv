# Configuration directories
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/homebrew/Brewfile"

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
