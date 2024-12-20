set shell := ["fish", "-c"]

switch:
    sudo nixos-rebuild switch --flake "."

switch-no-cache:
    sudo nixos-rebuild switch --flake "." --option eval-cache false

droid-switch:
    nix-on-droid switch --flake .

update:
    nix flake update
