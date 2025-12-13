{
  programs.ssh = {
    enable = true;
    programs.ssh.matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
    extraConfig = ''
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
