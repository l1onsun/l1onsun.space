{ pkgs, helix_pkg, ... }:

{
  home.username = "l1onsun";
  home.homeDirectory = "/home/l1onsun";

  home.sessionPath = [ "$HOME/.local/bin" ];

  imports = [
    ../programs/home_essential.nix
    ../programs/home_better.nix
    ../programs/home_gui.nix
    (import ../programs/alacritty.nix { font_size = 15; })
    (import ../programs/sway.nix { bar_font_size = 12.0; })
    ../programs/ssh.nix
    ../programs/aider.nix
    ../programs/tome4
    ../programs/vscode
    ../private
  ];
  programs.helix.package = helix_pkg;

  home.packages = [
    pkgs.unzip
    pkgs.foot
    pkgs.kitty
    # mailhog
    pkgs.smartmontools # ???

    pkgs.chromium
    pkgs.alacritty
    pkgs.onlyoffice-bin
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

    # pkgs.glow
    pkgs.marksman
    pkgs.pipx
    pkgs.gcc

    pkgs.grim
    pkgs.quickemu

    pkgs.python310
    pkgs.edir # mv files bulkly using editor
    pkgs.tea # gitea cli
    pkgs.git-crypt
    pkgs.neovim
    pkgs.kakoune

    pkgs.serpl # search and replace tool
    pkgs.reaper
    pkgs.musescore
    pkgs.zoom-us
    pkgs.woeusb

    pkgs.miraclecast
    # pkgs.gephi  # visualizing graphs

    # pkgs.nekoray
    pkgs.freetube
    pkgs.yt-dlp
  ];
  programs.firefox.enable = true;

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
