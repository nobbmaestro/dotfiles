# HELPER FUNCTIONS ------------------------------------------------------------
# check whether executable exists prior to alias
function safe_alias() {
    if command -v $2 1>/dev/null 2>&1; then
        alias $1="$2"
    else
        echo "command '$2' not found. Skipping..."
    fi
}

# append to path
function add_to_path() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

# prepend to path
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
