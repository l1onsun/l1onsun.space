{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    # package = pkgs.ssh;
    extraConfig = ''
        Host eris
          HostName 10.18.2.60
          User i.cherezov

        Host novosibirsk
          HostName 10.17.0.3
          Port 2228
          User opinion

        Host eris02
          HostName 10.18.2.110
          User i.cherezov

        Host eris03
          HostName 10.18.2.120
          User i.cherezov
          # User ilya.cherezov

        Host demo-ai-backend
          HostName 10.11.0.163
          User i.cherezov

        Host test_ray
          # module service
          HostName 10.11.0.9
          User i.cherezov

        Host test_module
          # module service 2
          HostName 10.18.2.40
          User ilya.cherezov

        Host machine230
          # Evgeny Sidorov
          HostName 193.106.172.230
          User ilya.cherezov

        Host demo-prod
          HostName 10.18.2.65
          User i.cherezov

        Host demo-stage
          HostName 10.11.0.163
          User i.cherezov

        # My services
        #   # firstbyte.ru 185.180.230.17 # скорее всего уже всё

        Host nl-proxy
          HostName 194.50.153.48
          User root

        Host nixi-gateway
          Hostname 176.124.192.235
          User root

        Host nixi
          Hostname 192.168.1.110
          User l1onsun

        # Host iphoster_net
          # HostName 178.32.173.226
          # User l1onsun

        # Host tg1
          # HostName tg1.cherezov.xyz
          # RequestTTY yes
          # User l1onsun

        # Host cherezov.space
        #   # firstbyte.ru 185.180.230.17
        #   # домен sprinthost.ru
        #   HostName 185.180.230.17  # cherezov.space
        #   Port 221
        #   User ilya

        # Host cherezov.xyz
        #   # reg.ru
        #   HostName 185.180.230.17  # cherezov.space
        #   Port 221
        #   User ilya
    '';
  };
}
