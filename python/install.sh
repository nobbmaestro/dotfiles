#!/usr/bin/env bash

COLOR_BLUE="\033[1;34m"
COLOR_NONE="\033[0m"

info() {
	echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}


install_python_packages() {
	local file=${1:-"packages"}

	if [ -f "$file" ]; then
		while IFS= read -r package; do
            info "installing: ${package}"
			pip install "$package"
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

cd -- "$(dirname -- "$0")" || exit 1
if [[ "$(command -v pyenv)" ]]; then
	install_python_versions "versions"
	install_python_packages "packages"
fi
