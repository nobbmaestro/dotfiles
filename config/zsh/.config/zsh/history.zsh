# History
# HISTSIZE=10000
# HISTFILE=~/.zsh_history
# SAVEHIST=$HISTSIZE
# HISTDUP=erase

# setopt appendhistory
# setopt sharehistory
# setopt hist_ignore_space
# setopt hist_ignore_all_dups
# setopt hist_save_no_dups

# Disable history
unset HISTFILE
export HISTSIZE=0
export SAVEHIST=0
setopt HIST_IGNORE_ALL_DUPS

setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt NO_GLOBAL_RCS
