{ pkgs, ... }:
{
    home.packages = [
      pkgs.networkmanagerapplet
      pkgs.networkmanager_dmenu  # https://github.com/firecat53/networkmanager-dmenu
    ];
}

