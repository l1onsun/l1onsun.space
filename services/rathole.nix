{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.myRathole;
  ratholeConfig = pkgs.writeText "rathole_client.toml" ''
    [client]
    remote_addr = "${cfg.addr}"
    default_token = "${cfg.token}"

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
in
{
  options.services.myRathole = {
    token = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "rathole token";
    };
    addr = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "rathole remote_addr";
    };
    enable = lib.mkEnableOption "Rathole Client";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.rathole
    ];

    systemd.services.rathole-clinet = {
      enable = cfg.enable && cfg.token != "" && cfg.addr != "";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      description = "My rathole client";
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = "5s";
        ExecStart = "${pkgs.rathole}/bin/rathole ${ratholeConfig}";
      };
    };
    warnings = lib.optional (
      cfg.enable && cfg.token == ""
    ) "myRathole включен, но токен не установлен! Сервис не будет запущен.";
  };
}
