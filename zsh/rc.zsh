# User configuration
source $ZDOTDIR/functions.zsh
source_if_exists $ZDOTDIR/profile.zsh
source_if_exists $ZDOTDIR/aliases.zsh
source_if_exists $ZDOTDIR/history.zsh
source_if_exists $HOME/repos/dotfiles/zsh/profile_work.zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch arm64"
