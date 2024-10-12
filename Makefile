TARGET ?= ${HOME}

.PHONY: all

all: symlink

symlink:
	@echo "Creating symlinks..."
	stow --restow --verbose --target=${TARGET} config bin --no-folding

clean:
	@echo "Cleaning up..."
	stow --delete --verbose --target=${TARGET} config bin
