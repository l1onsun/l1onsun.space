{ pkgs, ... }:
{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  home.packages = [
    pkgs.niri
  ];
  programs.waybar.enable = true;
}
