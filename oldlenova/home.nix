{ config, pkgs, ... }:

{
  home.username = "l1onsun";
  home.homeDirectory = "/home/l1onsun";

  imports = [
    ../programs/home_essential.nix
    ../programs/home_better.nix
    (import ../programs/alacritty.nix { font_size = 16; })
    (import ../programs/sway.nix { bar_font_size = 12.0; })
  ];

  home.packages = with pkgs; [
    smartmontools # ???

    chromium
    alacritty
    onlyoffice-bin
    nyxt
    librewolf
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system deveoped by swaywm maintainer
    fuzzel

    tuxguitar
    telegram-desktop
  ];
  programs.firefox.enable = true;


  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
