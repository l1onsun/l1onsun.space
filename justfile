set shell := ["fish", "-c"]

switch:
    sudo nixos-rebuild switch --flake "."

switch-upgrade-all:
    sudo nixos-rebuild switch --flake "." --upgrade-all

switch-no-cache:
    sudo nixos-rebuild switch --flake "." --option eval-cache false

droid-switch:
    nix-on-droid switch --flake .

update:
    nix flake update

current-nixpkgs-rev:
    #!/usr/bin/env fish
    set input_name (jq -r '.nodes.root.inputs.nixpkgs' flake.lock)
    set revision (jq -r --arg node_name "$input_name" '.nodes[$node_name].locked.rev' flake.lock)
    echo $revision


# It not working:
# update-template-nixpkgs:
#     # Get the input name for nixpkgs from root node
#     set input_name (jq -r '.nodes.root.inputs.nixpkgs' flake.lock)
    
#     # Extract the nixpkgs revision using the input name
#     set revision (jq -r ".nodes.\\\"\$input_name\\\".locked.rev" flake.lock)
    
#     # Change to templates/just/ directory and update nixpkgs to the same revision
#     cd templates/just/ && nix flake lock --override-input nixpkgs github:NixOS/nixpkgs/$revision
    
#     echo "Updated templates/just/ nixpkgs to revision: $revision"
