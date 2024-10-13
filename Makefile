TARGET ?= ${HOME}

.PHONY: all

all: symlink

install:
	@echo "Installing nix"
	nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/repos/dotfiles/nix#macbook-pro

rebuild:
	@echo "Rebuilding nix..."
	darwin-rebuild switch --flake ~/repos/dotfiles/nix#macbook-pro

symlink:
	@echo "Creating symlinks..."
	stow --restow --verbose --target=${TARGET} config bin --no-folding

clean:
	@echo "Cleaning up..."
	stow --delete --verbose --target=${TARGET} config bin
