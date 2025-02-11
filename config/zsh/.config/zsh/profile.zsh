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
