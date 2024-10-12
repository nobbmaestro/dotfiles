# HELPER FUNCTIONS ------------------------------------------------------------
#
function source_if_exists() {
	if test -e "$1"; then
		source "$1"
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

# find string in file
function fstr() {
	grep -Rnw "." -e "$1"
}

# SSH wrapper
function ssh() {
	if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
		tmux rename-window "$(echo $*)"
		command ssh "$@"
		tmux set-window-option automatic-rename "on" 1>/dev/null
	else
		command ssh "$@"
	fi
}
