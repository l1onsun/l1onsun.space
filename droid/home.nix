{ upkgs, ... }:

{
  # home.username = "l1onsun";
  # home.homeDirectory = "/home/l1onsun";
  nixpkgs.overlays = [
    (self: super: {
      skim = upkgs.skim;
    })
  ];

  imports = [
    (import ../programs/helix.nix {pkgs = upkgs;})
    (import ../programs/zellij {pkgs = upkgs;})
    (import ../programs/direnv.nix {pkgs = upkgs;})
    (import ../programs/git.nix {pkgs = upkgs;})
    (import ../programs/fish {pkgs = upkgs;})
    (import ../programs/tmux.nix {pkgs = upkgs;})
  ];
  programs.fish.shellInit = ''
    set -ga fish_features no-keyboard-protocols
  '';
  # programs.direnv.package = upkgs.direnv;
  # programs.zellij.package = upkgs.zellij;
  # programs.git.package = upkgs.git;
  # programs.tmux.package = upkgs.tmux;
  # Packages that should be installed to the user profile.
  home.packages = with upkgs; [
    neofetch
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    fzf # A command-line fuzzy finder
    sd
    # ipython
    bind
    inetutils
  ];

  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  # programs.home-manager.enable = true;
}

