{ pkgs, ... }:
let
  ratholeConfig = pkgs.writeText "rathole_server.toml" ''
    [server]
    bind_addr = "0.0.0.0:2340"
    default_token = "asdaefwqgqfdsfasq;"

    [server.services.nas_ssh]
    bind_addr = "0.0.0.0:5200"

    [server.services.immich]
    bind_addr = "0.0.0.0:5201"

    [server.services.happy_tg_bot]
    bind_addr = "0.0.0.0:5202"

    [server.services.vikunja]
    bind_addr = "0.0.0.0:5203"

    [server.services.wastebin]
    bind_addr = "0.0.0.0:5204"

    [server.services.gramps]
    bind_addr = "0.0.0.0:5205"
  '';
in {
  systemd.services.rathole-server = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    description = "My rathole server";
    serviceConfig = {
        Type = "simple";
        Restart="on-failure";
        RestartSec="5s";
        ExecStart = "${pkgs.rathole}/bin/rathole ${ratholeConfig}";
    };
  };
  environment.systemPackages =  [
    pkgs.rathole
  ];
}
