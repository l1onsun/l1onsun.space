{ config, lib, pkgs, upkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with upkgs; [
    # helix
    # fish
    git
    openssh
    htop
    bottom
    bat
    tree
    killall
    # inputs.helix.packages."x86_64-linux".default
    yazi
    zoxide
    nil
    nixfmt-rfc-style
    w3m
    just
    onefetch
    ncdu
    # tmux
    # tmuxPlugins.rose-pine

    pueue
    cmatrix
    lolcat

    iosevka
  ];
  environment.sessionVariables = {
    EDITOR = "${upkgs.helix}/bin/hx";
  };
  terminal.font = "${upkgs.iosevka}/share/fonts/truetype/Iosevka-Regular.ttf";
  terminal.colors = {
    background = "#191724";
    foreground = "#e0def4";
  };

  user.shell = "${upkgs.fish}/bin/fish";

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
    extraSpecialArgs = { inherit upkgs; };
  };
  # Set your time zone
  time.timeZone = "Europe/Kaliningrad";
}
