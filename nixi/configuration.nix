# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  opkgs,
  ...
}:

{
  # nixpkgs.overlays = [
  #   (final: prev: { helix = inputs.helix.packages.${final.system}.default; })
  #   inputs.niri.overlays.niri
  # ];
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../services/nix-ld.nix
    # ../services/rathole.nix
    # ../services/smtp
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.useTmpfs = true;

  networking.hostName = "nixi"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Kaliningrad";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.l1onsun = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "sudo"
      "video"
      "docker"
    ];
    shell = pkgs.fish;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "root"
    "l1onsun"
  ];
  
  environment.systemPackages = with pkgs; [
    fish
    starship
    helix
    bat
    tree
    killall
    broot
    yazi
    ueberzugpp
    zoxide
    nil
    nixfmt-rfc-style
    w3m
    just
    speedtest-cli
    onefetch
    skopeo
    ncdu
    # jujutsu
    # cachix
  ];
  environment.variables.EDITOR = "hx";
  fonts.packages = [
    pkgs.noto-fonts
    # pkgs.noto-fonts-cjk
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-emoji
    opkgs.iosevka
    pkgs.font-awesome
  ];
  security.polkit.enable = true;
  security.rtkit.enable = true;  # for pulseaudio?? not sure it necessery
  security.sudo.package = pkgs.sudo.override { withInsults = true; };

  programs.light.enable = true;
  programs.fish.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Enable the gnome-keyring secrets vault. 
  services.gnome.gnome-keyring.enable = true;
  # Will be exposed through DBus to programs willing to store secrets.
  services.xserver.videoDrivers = [ "nvidia" ];

  networking.firewall.allowedTCPPorts = [
     2283
     8017
     8000 # marketw
     8025 # marketw
   ];


  # TODO: rootless docker
  # virtualisation.docker.enable = true;
  # virtualisation.docker.package = pkgs.docker_28;
  # virtualisation.docker.storageDriver = "btrfs";


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11"; # DO NOT CHANGE!
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
}
