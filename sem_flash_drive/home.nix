{ pkgs, ... }:

{
  home.username = "reet";
  home.homeDirectory = "/home/reet";

  imports = [
    ../programs/home_essential.nix
    ../programs/home_better.nix
    ../programs/home_gui.nix
    (import ../programs/alacritty.nix { font_size = 15; })
    (import ../programs/sway.nix { bar_font_size = 12.0; })
    ../programs/tome4
  ];

  home.packages = [
    pkgs.unzip
    pkgs.foot
    pkgs.kitty
    # mailhog
    pkgs.smartmontools # ???

    pkgs.chromium
    pkgs.alacritty
    pkgs.onlyoffice-bin
    pkgs.wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    pkgs.mako # notification system deveoped by swaywm maintainer
    pkgs.fuzzel

    pkgs.tuxguitar
    pkgs.telegram-desktop

    pkgs.steam
    # opkgs.tome4

    pkgs.harper
    # pkgs.busybox

    pkgs.daggerfall-unity

    pkgs.fheroes2
    pkgs.vscode
  ];
  programs.firefox.enable = true;

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

