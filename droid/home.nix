{ config, pkgs, ... }:

{
  # home.username = "l1onsun";
  # home.homeDirectory = "/home/l1onsun";

  imports = [
    ../programs/helix.nix
    ../programs/zellij.nix
    ../programs/direnv.nix
    ../programs/git.nix
    ../programs/fish
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    fzf # A command-line fuzzy finder
  ];

  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  # programs.home-manager.enable = true;
}

