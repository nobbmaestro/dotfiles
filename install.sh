#!/usr/bin/env bash

DOTFILES="$(pwd)"

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


backup_file() {
    local file=$1 
    local rdir=$(echo "$(dirname $file)" | sed "s|^$HOME/||")

    # set target directory
    if [ $rdir != $HOME ]; then
        target_dir="$BACKUP_DIR"/"$rdir"
    else
        target_dir="$BACKUP_DIR"
    fi

    # check whether target directory exist, create if not
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
    fi

    # check if source file/directory exist and make copy on true
    if [ -f "$file" ]; then
        info "backing up file: $file"
        cp "$file" "$target_dir"
    elif [ -d "$file" ]; then
        info "backing up directory: $file"
        cp -rf "$file" "$target_dir"
    fi
}

backup_runner() {
    BACKUP_DIR=$HOME/dotfiles-backup

    title "Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    find -H "$DOTFILES" -maxdepth 3 -name '*.prop' | while read linkfile
    do
        cat "$linkfile" | while read line
        do
            local src dst dir
            src=$(eval echo "$line" | cut -d '=' -f 1)
            dst=$(eval echo "$line" | cut -d '=' -f 2)
            dir=$(dirname $dst)

            backup_file "$dst"
        done
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
        info "Homebrew not installed. Installing."
        # Run as a login shell (non-interactive) so that the script doesn't pause for user input
        # curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if [ "$(uname)" == "Linux" ]; then
        setup_ubuntu_reqs

        test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
        test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
        echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
    else
        echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile
    fi

    # install brew dependencies from Brewfile
    brew bundle
    brew bundle cleanup
}

link_file() {
    local src=$1 dst=$2 dir=$3
    
    # check whether source is a directory
    if [ -d "$src" ]; then
        info "linking directory: $src -> $dst"
        rm -rf $dst
        ln -s $src $dst
    else
        # check whether directory exists
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
        fi
        info "linking file: $src -> $dst" 
        rm -rf $dst
        ln -s $src $dst
    fi
}

link_runner() {
    title "Creating symlinks"

    find -H "$DOTFILES" -maxdepth 3 -name '*.prop' | while read linkfile
    do
        cat "$linkfile" | while read line
        do
            local src dst dir
            src=$(eval echo "$line" | cut -d '=' -f 1)
            dst=$(eval echo "$line" | cut -d '=' -f 2)
            dir=$(dirname $dst)
            
            link_file "$src" "$dst" "$dir"
        done
    done
}

setup_shell() {
    title "Configuring shell"

    [[ -n "$(command -v brew)" ]] && zsh_path="$(brew --prefix)/bin/zsh" || zsh_path="$(which zsh)"
    if ! grep "$zsh_path" /etc/shells; then
        info "adding $zsh_path to /etc/shells"
        echo "$zsh_path" | sudo tee -a /etc/shells
    fi

    if [[ "$SHELL" != "$zsh_path" ]]; then
        chsh -s "$zsh_path"
        info "default shell changed to $zsh_path"
    
        if [ ! -d $HOME/.oh-my-zsh ]; then
            info "fetching oh-my-zsh"
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi

        info "cloning powerlevel10k"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k        

    fi
    if [ ! -f $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
        info "fetching packer.nvim"
        git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    fi
    
    if [ ! -d $HOME/tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    if [ -d $(pwd)/terminfo/files ]; then
        info "configuring terminfo"
        tic $(pwd)/terminfo/files/xterm-256color-italic.terminfo
        tic -x $(pwd)/terminfo/files/tmux-256color.terminfo
    fi

}

# Only run if you pass in parameters. Wont't run everything by defualt, unless you pass in: './install.sh all'
case "$1" in
    backup)
        backup_runner 
        ;;
    brew)
        setup_homebrew
        ;;
    shell)
        setup_shell
        ;;
    link)
        link_runner
        ;;
    all)
        backup_runner
        setup_homebrew
        setup_shell
        link_runner
        ;;
    *)
        echo -e $"\nUsage: $(basename "$0") {backup|brew|shell|link|all}\n"
        exit 1
        ;;
esac

echo -e
success "Done."
