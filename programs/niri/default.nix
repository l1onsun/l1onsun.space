{ pkgs, ... }:
{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  programs.waybar.enable = true;
  home.packages = [
    pkgs.xwayland-satellite
    pkgs.fuzzel
  ];
}
