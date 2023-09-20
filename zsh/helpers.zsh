# HELPER FUNCTIONS ------------------------------------------------------------
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
