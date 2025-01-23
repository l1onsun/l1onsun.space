{ pkgs, ... }:
let
  ratholeConfig = pkgs.writeText "rathole_client.toml" ''
    [client]
    remote_addr = "176.124.192.235:2340"
    default_token = "use_a_secret_that_anyone_knows"

    [client.services.nas_ssh]
    local_addr = "127.0.0.1:22"

    [client.services.immich]
    local_addr = "0.0.0.0:2283"

    [client.services.happy_tg_bot]
    local_addr = "127.0.0.1:8443"

    [client.services.test_market]
    local_addr = "127.0.0.1:8000"

    [client.services.test_market_mailhog]
    local_addr = "127.0.0.1:8025"

    [client.services.smtp]
    local_addr = "0.0.0.0:25"
  '';
in {
  environment.systemPackages =  [
    pkgs.rathole
  ];

  systemd.services.rathole-clinet = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    description = "My rathole client";
    serviceConfig = {
        Type = "simple";
        Restart="on-failure";
        RestartSec="5s";
        ExecStart = "${pkgs.rathole}/bin/rathole ${ratholeConfig}";
    };
  };
}
