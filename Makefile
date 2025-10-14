TARGET ?= ${HOME}

STOW_FLAGS := --verbose --target=$(TARGET)
ifeq ($(CI),true)
  STOW_FLAGS += --ignore="(^|/)\.gitconfig$$"
endif

STOW	:= stow --restow $(STOW_FLAGS)
UNSTOW	:= stow --delete $(STOW_FLAGS)

.PHONY: all stow-all clean

all: stow-all

stow-all:
	@echo "Creating symlinks..."
	@(cd config && $(STOW) */)

clean:
	@echo "Cleaning up..."
	@(cd config && $(UNSTOW) */)
