{ inputs }:
let
  system = "x86_64-linux";
in
{
  vps = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit system; };
    modules = [
      inputs.disko.nixosModules.disko
      (
        { config, pkgs, ... }:
        {
          imports = [
            ./disk-config.nix
            ./rathole.nix
          ];

          # Basic networking setup
          networking.useDHCP = false;
          networking.hostName = "msk-cherezov-xyz";
          networking.interfaces.ens3 = {
            useDHCP = false;
            ipv4.addresses = [
              {
                address = "176.124.192.137";
                prefixLength = 23;
              }
            ];
          };
          networking.defaultGateway = "176.124.192.1";

          networking.firewall.allowedTCPPorts = [
            22
            80
            443
            2340 # rathole
            5200 # rathole ssh
          ];
          networking.nameservers = [
            "1.1.1.1"
            "8.8.8.8"
          ];

          # SSH for nixos-anywhere
          services.openssh.enable = true;
          services.openssh.settings.PasswordAuthentication = false;

          users.users.root.initialPassword = "smal";
          users.users.root.shell = pkgs.fish;
          programs.fish.enable = true;
          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF0+rOV971OED1K9GxEoZ6/I2QqX2mphNbHy2M+0wMEM l1onsun@nixi"
          ];
          environment.systemPackages = [
            pkgs.helix
            pkgs.tmux
          ];

          # Enable Caddy web server
          services.caddy = {
            enable = true;
            virtualHosts."cherezov.xyz".extraConfig = ''
              respond "Hello from Caddy on NixOS! (wedding soon!)"
            '';
            virtualHosts."tg.cherezov.xyz".extraConfig = ''
              reverse_proxy http://0.0.0.0:5202
            '';
            virtualHosts."photo.cherezov.xyz".extraConfig = ''
              reverse_proxy http://0.0.0.0:5201
            '';
            virtualHosts."immich.cherezov.xyz".extraConfig = ''
              reverse_proxy http://0.0.0.0:5201
            '';
            virtualHosts."todo.cherezov.xyz".extraConfig = ''
              reverse_proxy http://0.0.0.0:5203
            '';
            virtualHosts."paste.cherezov.xyz".extraConfig = ''
              reverse_proxy http://0.0.0.0:5204
            '';
          };

          # Timezone / locale
          time.timeZone = "Europe/Kaliningrad";
          i18n.defaultLocale = "en_US.UTF-8";

          # Allow flakes and nix-command
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
          virtualisation.docker.enable = true;
          system.stateVersion = "25.11"; # Do not change!
        }
      )
      inputs.nixos-facter-modules.nixosModules.facter
      { config.facter.reportPath = ./facter.json; }

    ];
  };
}
