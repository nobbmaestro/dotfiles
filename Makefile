TARGET ?= ${HOME}

STOW_FLAGS := --verbose --target=$(TARGET)
ifeq ($(CI),true)
  STOW_FLAGS += --ignore="(^|/)\.gitconfig$$"
endif

STOW	:= stow --restow $(STOW_FLAGS)
UNSTOW	:= stow --delete $(STOW_FLAGS)

.PHONY: all stow-all clean

all: stow-all

install:
	@echo "Installing Nix Package Manager..."
	@curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh

uninstall:
	@echo "Uninstalling Nix Package Manager..."
	@(sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller)

stow-all:
	@echo "Creating symlinks..."
	@(cd config && $(STOW) */)

clean:
	@echo "Cleaning up..."
	@(cd config && $(UNSTOW) */)
