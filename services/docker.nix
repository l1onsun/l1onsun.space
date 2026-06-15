{
  virtualisation.docker.enable = true;
  # virtualisation.docker.package = pkgs.docker_26;
  virtualisation.docker.storageDriver = "btrfs";
  virtualisation.docker.enableOnBoot = false;

  systemd.services.docker.serviceConfig.Environment = [
    "HTTP_PROXY=http://127.0.0.1:3738"
    "HTTPS_PROXY=http://127.0.0.1:3738"
    "NO_PROXY=localhost,127.0.0.1"
  ];
}

