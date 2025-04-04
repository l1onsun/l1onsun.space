{ pkgs, ... }:

{
  home.username = "l1onsun";
  home.homeDirectory = "/home/l1onsun";

  imports = [
    ../programs/home_essential.nix
    ../programs/home_better.nix
    (import ../programs/alacritty.nix { font_size = 18; })
    (import ../programs/sway.nix { bar_font_size = 14.0; })
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    smartmontools

    chromium
    alacritty
    firefox
    # nyxt
    librewolf
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout

    tuxguitar
    telegram-desktop
  ];
  programs.waybar.enable = true;


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
