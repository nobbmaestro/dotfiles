#!/usr/bin/env bash

set -eo pipefail

export ZDOTDIR="$HOME/.config/zsh"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.local/share/tmux/plugins"

BREWFILE="config/homebrew/.config/homebrew/Brewfile"

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

setup_python() {
    title "Setting up Python"
    ./resources/python/install.sh
}

install_tmux_package_manager_helper() {
    if [ ! -d "$TMUX_PLUGIN_MANAGER_PATH/tpm" ]; then
        info "installing: tmux tpm"
        git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_MANAGER_PATH/tpm"
    else
        info "utility already installed: tpm"
    fi
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
    brew bundle --file="${BREWFILE}"
    brew bundle cleanup --file="${BREWFILE}" --force
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
        tic "$(pwd)/resources/terminfo/files/xterm-256color-italic.terminfo"
        tic -x "$(pwd)/resources/terminfo/files/tmux-256color.terminfo"
    fi
}

setup_tmux() {
    title "Setting up Tmux"
    if [[ "$(command -v tmux)" ]]; then
        install_tmux_package_manager_helper
        info "downloading tmux plugins..."
        "$TMUX_PLUGIN_MANAGER_PATH/tpm/scripts/install_plugins.sh" "" --unattended
    else
        warning "command not found: tmux"
    fi
}

setup_neovim() {
    title "Setting up NeoVim"
    if [[ "$(command -v bob)" ]]; then
        bob install 0.9.2
        if [[ -z "$CI" ]]; then
            bob use 0.9.2
        fi
    else
        warning "command not found: bob"
    fi
}

# Only run if you pass in parameters. Wont't run everything by defualt, unless you pass in: './install.sh all'
case "$1" in
brew)
    setup_homebrew
    ;;
zsh)
    setup_zsh
    ;;
tmux)
    setup_tmux
    ;;
neovim)
    setup_neovim
    ;;
python)
    setup_python
    ;;
all)
    setup_homebrew
    setup_zsh
    setup_tmux
    setup_neovim
    setup_python
    ;;
*)
    echo -e $"\nUsage: $(basename "$0") [backup|brew|zsh|tmux|python|symlink|all]\n"
    exit 1
    ;;
esac

echo -e
success "Done."
