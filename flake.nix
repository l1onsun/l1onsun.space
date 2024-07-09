{
  description = "A simple NixOS flake";
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://helix.cachix.org"
      "https://niri.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # helix.url = "github:helix-editor/helix";
    # niri.url = "github:sodiboo/niri-flake";
  };

  outputs = inputs: {
    nixosConfigurations.nixi = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # {
        #   nixpkgs.overlays = [
        #     (final: prev: { helix = inputs.helix.packages.${final.system}.default; })
        #     inputs.niri.overlays.niri
        #   ];
        # }
        # inputs.niri.nixosModules.niri
        # inputs.niri.homeModules.niri

        ./configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.l1onsun = import ./home.nix;
        }
      ];
    };
  };
}
