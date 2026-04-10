# Setup PATH
add_to_path_front $HOME/.local/bin

# Configure Go binary destination
export GOBIN=$HOME/.local/bin

# Configure EXA colors
export EZA_COLORS="di=37;1:fi=37:ex=31:ln=35;1"

# Configure fzf colors
export FZF_DEFAULT_OPTS='
	--color=fg:-1,hl:#00e8c6
	--color=fg+:,bg+:#2f323c,hl+:#00e8c6
	--color=info:#606064,prompt:#d5ced9,pointer:#00e8c6
	--color=marker:#87ff00,spinner:#ff0000,header:#87afaf'

# CUnit
if [[ -d $(brew --prefix)/opt/cunit/include ]]; then
	C_INCLUDE_PATH=$(brew --prefix)/opt/cunit/include
	export C_INCLUDE_PATH
fi
if [[ -d $(brew --prefix)/opt/cunit/lib ]]; then
	LIBRARY_PATH=$(brew --prefix)/opt/cunit/lib
	export LIBRARY_PATH
fi

# Configure UV ref: https://www.jrisner.dev/blog/migrating-from-pyenv-to-uv/
export UV_DIR="${HOME}/.uv"
export UV_CACHE_DIR="${UV_DIR}/cache"
export UV_PYTHON_INSTALL_DIR="${UV_DIR}/python/versions"
export UV_PYTHON_BIN_DIR="${UV_DIR}/python/bin"
export UV_TOOL_DIR="${UV_DIR}/tools"
export UV_TOOL_BIN_DIR="${UV_DIR}/bin"
export PATH="${UV_PYTHON_BIN_DIR}:${UV_TOOL_BIN_DIR}:${PATH}"
export UV_PYTHON_DOWNLOADS=manual
export UV_PYTHON_PREFERENCE=only-managed
export UV_VENV_SEED=true
