#!/usr/bin/env bash

set -e

COLOR_BLUE="\033[1;34m"
COLOR_NONE="\033[0m"

info() {
    echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

install_python_packages() {
    local exec=${1:-"pip"}
    local file=${2:-"packages"}

    if [ -f "$file" ]; then
        while IFS= read -r package; do
            info "installing: ${package}"
            ${exec} install "$package"
        done <"$file"
    fi
}

install_python_versions() {
    local file=${1:-"versions"}

    if [ -f "$file" ]; then
        info "installing: Python"
        while read -r line; do
            local version
            version=$(eval echo "$line" | cut -d '=' -f 1)

            if [[ ! $(pyenv versions) =~ ${version} ]]; then
                info "installing: Python ${version}"
                pyenv install "${version}"
            fi

            if [[ "$line" == *"=GLOBAL" ]]; then
                info "setting global: ${version}"
                pyenv global "${version}"
            fi
        done <"$file"
    fi
}

cd -- "$(dirname -- "$0")"
if [[ "$(command -v pyenv)" ]]; then
    install_python_versions "versions"
    pip install pipx
    install_python_packages "pipx" "packages"
fi
