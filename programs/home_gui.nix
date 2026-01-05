{ pkgs, ... }:
{
    home.packages = [
      pkgs.networkmanagerapplet
      pkgs.networkmanager_dmenu  # https://github.com/firecat53/networkmanager-dmenu
      pkgs.localsend
      pkgs.vial # keyboard settings
    ];
}

