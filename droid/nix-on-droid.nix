{ config, lib, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    helix
    fish
    git
    openssh
    htop
    bottom
    bat
    tree
    zellij
    killall
    gawk
    gnused
    # inputs.helix.packages."x86_64-linux".default
    yazi
    zoxide
    nil
    nixfmt-rfc-style
    difftastic
    w3m
    just
    onefetch
    ncdu
    pueue

    iosevka
  ];
  environment.sessionVariables = {
    EDITOR = "helix";
  };
  terminal.font = "${pkgs.iosevka}/share/fonts/truetype/Iosevka-Regular.ttf";
  terminal.colors = {
    background = "#191724";
    foreground = "#e0def4";
  };

  user.shell = "${pkgs.fish}/bin/fish";

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  android-integration.termux-setup-storage.enable = true;
  home-manager = {
    config = ./home.nix;
    backupFileExtension = "hm-backup";
    useGlobalPkgs = true;
  };
  # Set your time zone
  #time.timeZone = "Europe/Berlin";
}
