# ALIASES ---------------------------------------------------------------------
alias vim="nvim"

# GIT ALIASES -----------------------------------------------------------------
# alias gc='git commit'
# alias gco='git checkout'
# alias ga='git add'
# alias gb='git branch'
# alias gba='git branch --all'
# alias gbd='git branch -D'
# alias gcp='git cherry-pick'
# alias gd='git diff -w'
# alias gds='git diff -w --staged'
# alias grs='git restore --staged'
# alias gu='git reset --soft HEAD~1'
# alias gcan='gc --amend --no-edit'
# alias gpf='git push --force-with-lease'
# alias gl=pretty_git_log
# alias gla=pretty_git_log_all

# FUNCTIONS -------------------------------------------------------------------
function add_to_path() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

function add_to_path_front() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

# benchmark zsh performance
function benchmark_zsh() {
   shell=${1-$SHELL}
   for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
