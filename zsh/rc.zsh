# User configuration
source $ZDOTDIR/.zsh_helpers
source_if_exists $ZDOTDIR/.zsh_profile
source_if_exists $ZDOTDIR/.zsh_aliases
source_if_exists $HOME/repos/dotfiles/zsh/profile_work.zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch arm64"
