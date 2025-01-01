{ config, pkgs, ... }:

{
  home.username = "l1onsun";
  home.homeDirectory = "/home/l1onsun";

  imports = [
    ../programs/helix.nix
    ../programs/zellij
    ../programs/direnv.nix
    (import ../programs/alacritty.nix { font_size = 18; })
    ../programs/git.nix
    (import ../programs/sway.nix { bar_font_size = 12.0; })
  ];

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    # eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # btop # replacement of htop/nmon
    smartmontools
    # iotop # io monitoring
    # iftop # network monitoring

    # system call monitoring
    # strace # system call monitoring
    # ltrace # library call monitoring
    # lsof # list open files

    # system tools
    # sysstat
    # lm_sensors # for `sensors` command
    # ethtool
    # pciutils # lspci
    # usbutils # lsusb

    chromium
    alacritty
    firefox
    nyxt
    librewolf
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout

    tuxguitar
    telegram-desktop
  ];
  # programs.niri.package = pkgs.niri-unstable;
  # programs.niri.enable = true;
  # programs.niri.settings.input = {
  #   keyboard = {
  #     xkb = {
  #       layout = "us,ru";
  #       options = "grp:alt_shift_toggle";
  #     };
  #   };
  #   repeat-delay = 180;
  #   repeat-rate = 30;
  # };

  # basic configuration of git, please change to your own
  programs.waybar.enable = true;

  # starship - an customizable prompt for any shell
  # programs.starship = {
  #   enable = true;
  #   # custom settings
  #   # settings = {
  #   #   add_newline = false;
  #   #   aws.disabled = true;
  #   #   gcloud.disabled = true;
  #   #   line_break.disabled = true;
  #   # };
  # };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator

  # programs.bash = {
  #   enable = true;
  #   enableCompletion = true;
  #   # TODO add your custom bashrc here
  #   bashrcExtra = ''
  #     export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
  #   '';

  #   # set some aliases, feel free to add more or remove some
  #   shellAliases = {
  #     k = "kubectl";
  #     urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
  #     urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  #   };
  # };

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
