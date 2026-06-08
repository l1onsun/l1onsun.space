{ pkgs, ... }:
{
  imports = [ ./git.nix ];

  home.packages = [
    pkgs.git-credential-manager
    pkgs.xdg-utils
  ];

  programs.git = {
    settings = {
      user.name = "Ilya Cherezov";
      user.email = "cherezov.ia@phystech.edu";

      credential.helper = "manager";
      credential.credentialStore = "secretservice";
    };
  };
}
