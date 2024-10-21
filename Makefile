TARGET ?= ${HOME}

.PHONY: all

all: symlink

install:
	@echo "Installing nix"
	nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/repos/dotfiles/nix#default

rebuild:
	@echo "Rebuilding nix..."
	darwin-rebuild switch --flake ~/repos/dotfiles/nix#default

symlink:
	@echo "Creating symlinks..."
	stow --restow --verbose --target=${TARGET} config bin nix --no-folding

clean:
	@echo "Cleaning up..."
	stow --delete --verbose --target=${TARGET} config bin nix
