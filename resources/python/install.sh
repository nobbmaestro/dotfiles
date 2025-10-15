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

            info "installing: Python ${version}"
            uv python install "${version}"

            if [[ "$line" == *"=GLOBAL" ]]; then
                info "setting global: ${version}"
                uv python install "${version}" --default
                uv python pin "${version}"
            fi
        done <"$file"
    fi
}

cd -- "$(dirname -- "$0")"
if [[ "$(command -v uv)" ]]; then
    install_python_versions "versions"
    install_python_packages "uv tool" "packages"
fi
