#!/usr/bin/env bash

export ZDOTDIR="$HOME/.config/zsh"
export ZSH="$ZDOTDIR/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

DOTFILES="$(pwd -P)"
BACKUP_DIR="$HOME/dotfiles-backup"

COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

title() {
	echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
	echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
	echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
	exit 1
}

warning() {
	echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
	echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
	echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

truncate_path() {
	local path="$1"
	echo "${path/#$HOME/~}"
}

install_oh_my_zsh_helper() {
	if [ ! -d "$ZSH" ] || [ ! -e "$ZSH/oh-my-zsh.sh" ]; then
		info "installing: oh-my-zsh"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	else
		info "utility already installed: oh-my-zsh"
	fi
}

install_powerlevel10k_helper() {
	if [ ! -d "$ZSH/custom/themes/powerlevel10k" ]; then
		info "installing: powerlevel10k"
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$ZSH/custom}/themes/powerlevel10k"
	else
		info "utility already installed: powerlevel10k"
	fi
}

install_tmux_package_manager_helper() {
	if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
		info "installing: tmux tpm"
		git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
	else
		info "utility already installed: tpm"
	fi
}

install_zsh_utils() {
	title "Installing zsh utilities"

	# Install zsh utilities
	install_oh_my_zsh_helper
	install_powerlevel10k_helper
}

backup_target_file() {
	local root_dir file=$1
	root_dir="$(truncate_path "$file")"

	# set target directory
	if [ "$root_dir" != "$HOME" ]; then
		target_dir="$BACKUP_DIR"/"$root_dir"
	else
		target_dir="$BACKUP_DIR"
	fi

	# check whether target directory exist, create if not
	if [ ! -d "$target_dir" ]; then
		mkdir -p "$target_dir"
	fi

	# check if source file/directory exist and make copy on true
	if [ -f "$file" ]; then
		info "backing up file: \t$(truncate_path "$file")"
		cp "$file" "$target_dir"
	elif [ -d "$file" ]; then
		info "backing up dir: \t$(truncate_path "$file")"
		cp -rf "$file" "$target_dir"
	fi
}

create_backup() {
	title "Creating backup directory at: $BACKUP_DIR"
	mkdir -p "$BACKUP_DIR"

	find -H "$DOTFILES" -maxdepth 3 -name '*.prop' | while read -r linkfile; do
		while read -r line; do
			local src dst dir
			src=$(eval echo "$line" | cut -d '=' -f 1)
			dst=$(eval echo "$line" | cut -d '=' -f 2)
			dir=$(dirname "$dst")

			backup_target_file "$dst"
		done <"$linkfile"
	done
}

setup_ubuntu_reqs() {
	if [ "$(uname)" == "Linux" ]; then
		title "Setting up Ubuntu"

		sudo apt-get update
		sudo apt-get install build-essential procps curl file git
	fi
}

setup_homebrew() {
	title "Setting up Homebrew"

	if test ! "$(command -v brew)"; then
		info "installing: homebrew"
		# Run as a login shell (non-interactive) so that the script doesn't pause for user input
		# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	else
		info "utility already installed: homebrew"
	fi

	if [ "$(uname)" == "Linux" ]; then
		setup_ubuntu_reqs

		# TODO Remove writing to bash_profile, zsh_profile is already taking care of this
		test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
		test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
		test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
		echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile
	else
		export PATH=/opt/homebrew/bin:$PATH
	fi

	# install brew dependencies from Brewfile
	brew bundle
	brew bundle cleanup
}

symlink_target_file() {
	local src=$1 dst=$2 dir=$3

	# check whether symlink exists and is working properly
	if [ -L "$dst" ] && [ -e "$dst" ] && [ "$(readlink "$dst")" == "$src" ]; then
		info "symlink already exists:   $(truncate_path "$dst")"

	else
		# check whether source is a directory
		if [ -d "$src" ]; then
			info "creating symlink to dir:  $(truncate_path "$src") -> $(truncate_path "$dst")"
			rm -rf "$dst"
			ln -s "$src" "$dst"
		else
			# check whether directory exists
			if [ ! -d "$dir" ]; then
				mkdir -p "$dir"
			fi
			info "creating symlink to file: $(truncate_path "$src") -> $(truncate_path "$dst")"
			rm -f "$dst"
			ln -s "$src" "$dst"
		fi
	fi
}

create_symlinks() {
	local path=""

	# check if argument is given
	if [ -z "$1" ]; then
		warning "argument not specified"

	# check if argument is 'all'
	elif [[ "$1" == "all" ]]; then
		path="$DOTFILES"

	# check if argument is an existing path
	elif [ -d "$1" ]; then
		path="$1"

	else
		warning "invalid argument: $1"
	fi

	# Do nothing if path is empty
	if [ -n "$path" ]; then
		title "Creating symlinks from: $path"
		find -H "$path" -maxdepth 3 -name '*.prop' | while read -r linkfile; do
			while read -r line; do
				local src dst dir
				src=$(eval echo "$line" | cut -d '=' -f 1)
				dst=$(eval echo "$line" | cut -d '=' -f 2)
				dir=$(dirname "$dst")

				symlink_target_file "$src" "$dst" "$dir"
			done <"$linkfile"
		done
	fi
}

setup_zsh() {
	title "Setting up zsh"

	[[ -n "$(command -v brew)" ]] && zsh_path="$(brew --prefix)/bin/zsh" || zsh_path="$(which zsh)"

	# Add zsh to /etc/shells
	if ! grep -q "$zsh_path" /etc/shells; then
		info "adding $zsh_path to /etc/shells"
		echo "$zsh_path" | sudo tee -a /etc/shells
	else
		info "/etc/shells already contains: $zsh_path"
	fi

	# Setup defualt shell to zsh
	if [[ "$SHELL" != "$zsh_path" ]]; then
		info "changing default shell to: $zsh_path"
		if [[ "$zsh_path" == "/opt/homebrew/bin/zsh" ]]; then
			warning "given shell is non-standard shell. Skipping..."
		else
			chsh -s "$zsh_path" # not allowed because it is a non-standard shell
		fi
	fi

	# Setup terminfo
	if [ -d "$(pwd)/terminfo/files" ]; then
		info "configuring terminfo"
		tic "$(pwd)/terminfo/files/xterm-256color-italic.terminfo"
		tic -x "$(pwd)/terminfo/files/tmux-256color.terminfo"
	fi

	install_zsh_utils
	create_symlinks "$DOTFILES/zsh"
}

setup_tmux() {
	if [[ "$(command -v tmux)" ]]; then
		create_symlinks "$DOTFILES/tmux"
	fi

	title "Setting up Tmux"
	if [[ "$(command -v tmux)" ]]; then
		install_tmux_package_manager_helper
		info "downloading tmux plugins..."
		sh -c "$HOME/.config/tmux/plugins/tpm/scripts/install_plugins.sh" "" --unattended
	else
		warning "command not found: tmux"
	fi
}

# Only run if you pass in parameters. Wont't run everything by defualt, unless you pass in: './install.sh all'
case "$1" in
backup)
	create_backup
	;;
brew)
	setup_homebrew
	;;
zsh)
	setup_zsh
	;;
tmux)
	setup_tmux
	;;
symlink)
	create_symlinks all
	;;
all)
	create_backup
	setup_homebrew
	setup_zsh
	setup_tmux
	create_symlinks all
	;;
*)
	echo -e $"\nUsage: $(basename "$0") [backup|brew|zsh|tmux|symlink|all]\n"
	exit 1
	;;
esac

echo -e
success "Done."
