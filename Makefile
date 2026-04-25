HNAME := macbook-pro-m1

.PHONY: all

all: switch

install:
	@echo "Installing Nix Package Manager..."
	@curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh

uninstall:
	@echo "Uninstalling Nix Package Manager..."
	@sudo nix \
		--extra-experimental-features "nix-command flakes" \
		run \
		nix-darwin#darwin-uninstaller

switch:
	@echo "Rebuild for host: $(HNAME)"
	@if command -v darwin-rebuild >/dev/null 2>&1; then \
		sudo darwin-rebuild switch --flake .#$(HNAME); \
	else \
		echo "darwin-rebuild not found, bootstrapping..." && \
		sudo nix run nix-darwin \
			--extra-experimental-features "nix-command flakes" \
			-- switch \
			--flake .#$(HNAME); \
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
