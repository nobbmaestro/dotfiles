HNAME := macbook-pro-m1

.PHONY: all install uninstall switch check update clean

all: switch

install:
	@echo "Installing Nix (Determinate Systems)..."
	@curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

uninstall:
	@echo "Step 1: Uninstall nix-darwin..."
	@sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
	@echo "Step 2: Uninstall Nix (Determinate Systems)..."
	@/nix/nix-installer uninstall


switch:
	@echo "Rebuild for host: $(HNAME)"
	@if command -v darwin-rebuild >/dev/null 2>&1; then \
		sudo darwin-rebuild switch --flake .#$(HNAME); \
	else \
		echo "darwin-rebuild not found, bootstrapping..." && \
		sudo nix run nix-darwin -- switch --flake .#$(HNAME); \
	fi

check:
	@echo "Checking flake..."
	@nix flake check

update:
	@echo "Updating flake..."
	@nix flake update

clean:
	@echo "Collecting garbage..."
	@nix-store --gc
