{
  description = "A simple NixOS flake";
  nixConfig = {
    extra-substituters = [
      # "https://nix-community.cachix.org"
      "https://helix.cachix.org"
      # "https://niri.cachix.org"
    ];
    extra-trusted-public-keys = [
      # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      # "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-24-05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/master";
    helix-flake.url = "github:helix-editor/helix";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    let
      x86NixosSystem =
        { configurationPath, homePath }:
        let
          system = "x86_64-linux";
        in
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            opkgs = import inputs.nixpkgs-24-05 { inherit system; }; # iosevka
          };
          modules = [
            configurationPath
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                opkgs = import inputs.nixpkgs-24-05 { inherit system; };
                helix_pkg = inputs.helix-flake.packages.${system}.default;
                lpkgs = import inputs.nixpkgs-latest { inherit system; };
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.users.l1onsun = import homePath;
            }
          ];
        };
    in
    {
      nixosConfigurations.nixi = x86NixosSystem {
        configurationPath = ./nixi/configuration.nix;
        homePath = ./nixi/home.nix;
      };

      nixosConfigurations.oldlenova = x86NixosSystem {
        configurationPath = ./oldlenova/configuration.nix;
        homePath = ./oldlenova/home.nix;
      };

      nixosConfigurations.zenbook = x86NixosSystem {
        configurationPath = ./zenbook/configuration.nix;
        homePath = ./zenbook/home.nix;
      };

      nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import inputs.nixpkgs-24-05 {
          # pkgs = import inputs.nixpkgs {
          system = "aarch64-linux";
          overlays = [ inputs.nix-on-droid.overlays.default ];
        };
        # specialArgs = { inherit inputs; };
        modules = [
          ./droid/nix-on-droid.nix
          {
            # Set all inputs parameters as special arguments for all submodules,
            # so you can directly use all dependencies in inputs in submodules
            _module.args = {
              upkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
            };
          }
        ];
      };

      templates = {
        just = {
          path = ./templates/just;
          description = "The basic Template";
        };
      };
    };
}
