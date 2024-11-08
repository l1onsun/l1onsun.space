set shell := ["fish", "-c"]

switch:
    sudo nixos-rebuild switch --flake "."

switch-no-cache:
    sudo nixos-rebuild switch --flake "." --option eval-cache false

update:
    nix flake update
