# ALIASES ---------------------------------------------------------------------
# alias cat='bat'
# alias find='fd'
alias c='clear'
alias count='ls -a1 | wc -l'
alias lzg='lazygit'
alias lzd='lazydocker'
alias pretty_path="sh -c 'python3 ~/.local/bin/pretty_path.py $PATH'"
alias rm='rm -i'
alias vim='nvim'

# LS (EXA) ALIASES ------------------------------------------------------------
alias la='ls -al'
alias ll='ls -l'
alias ls='exa --icons --classify --group-directories-first'
alias lt='exa --tree --group-directories-first'

# BREW ALIASES ----------------------------------------------------------------
alias clean="sh -c 'brew autoremove; brew cleanup --prune=all'"
alias update="sh -c 'brew update; brew upgrade'"

# GIT ALIASES -----------------------------------------------------------------
# alias ga='git add'
# alias gb=pretty_git_branch_sorted
# alias gba='git branch --all'
# alias gbd='git branch -D'
# alias gc='git commit'
# alias gcan='gc --amend --no-edit'
# alias gco='git checkout'
# alias gcm='git checkout master'
# alias gcd='git checkout development'
# alias gcp='git cherry-pick'
# alias gd='git diff'
# alias gds='git diff --staged'
# alias gl=pretty_git_log
# alias gp='git push'
# alias gpl='git pull'
# alias gla=pretty_git_log_all
# alias gpf='git push --force-with-lease'
# alias grs='git restore --staged'
# alias gs='git status'
# alias gu='git reset --soft HEAD~1'
