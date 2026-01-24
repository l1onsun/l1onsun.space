{ pkgs, ... }:
{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  programs.waybar.enable = true;
  home.packages = [
    pkgs.niri
    pkgs.xwayland-satellite
    pkgs.fuzzel
  ];
}
