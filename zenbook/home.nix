{ pkgs, opkgs, ... }:

{
  home.username = "l1onsun";
  home.homeDirectory = "/home/l1onsun";

  imports = [
    ../programs/home_essential.nix
    ../programs/home_better.nix
    ../programs/home_gui.nix
    (import ../programs/alacritty.nix { font_size = 15; })
    (import ../programs/sway.nix { bar_font_size = 12.0; })
    ../programs/ssh.nix
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
    (pkgs.vscode-with-extensions.override {
      vscodeExtensions =
        [ pkgs.vscode-extensions.mvllow.rose-pine ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-helix-emulation";
            publisher = "jasew";
            version = "0.6.3";
            sha256 = "sha256-iHPAFzo1sJI+TMk0pzkuOPw2pTo7g44cZd1EWIifHyM=";
          }
        ];
    })
    pkgs.librewolf
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
    pkgs.nexusmods-app-unfree

    pkgs.fheroes2
  ];
  programs.firefox.enable = true;

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
