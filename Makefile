TARGET ?= ${HOME}

.PHONY: all

all: symlink

symlink:
	@echo "Creating symlinks..."
	stow --target=${TARGET} . -v

clean:
	@echo "Cleaning up..."
	stow --target=${TARGET} --delete . -v

