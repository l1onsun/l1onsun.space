{
  description = "A simple NixOS flake";
  # nixConfig = {
  #   extra-substituters = [
  #     # "https://nix-community.cachix.org"
  #     # "https://helix.cachix.org"
  #     # "https://niri.cachix.org"
  #   ];
  #   extra-trusted-public-keys = [
  #     # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #     # "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
  #     # "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
  #   ];
  # };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
  };

  outputs = inputs: {
    nixosConfigurations.nixi = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        opkgs = import inputs.nixpkgs-24-05 {
          system = "x86_64-linux";
        };
      };
      modules = [
        ./nixi/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.users.l1onsun = import ./nixi/home.nix;
        }
      ];
    };

    nixosConfigurations.oldlenova = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        opkgs = import inputs.nixpkgs-24-05 {
          system = "x86_64-linux";
        };
      };
      modules = [
        ./oldlenova/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.users.l1onsun = import ./oldlenova/home.nix;
        }
      ];
    };

    nixosConfigurations.zenbook = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        opkgs = import inputs.nixpkgs-24-05 {
          system = "x86_64-linux";
        };
      };
      modules = [
        ./zenbook/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit inputs;
            opkgs = import inputs.nixpkgs-24-05 {
              system = "x86_64-linux";
            };
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.users.l1onsun = import ./zenbook/home.nix;
        }
      ];
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
