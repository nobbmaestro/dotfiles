TARGET ?= ${HOME}
STOW := stow --restow --verbose --target=$(TARGET)
UNSTOW := stow --delete --verbose --target=$(TARGET)

.PHONY: all

all: stow-all

stow-all:
	@echo "Creating symlinks..."
	@(cd config && $(STOW) */)

clean:
	@echo "Cleaning up..."
	@(cd config && $(UNSTOW) */)
