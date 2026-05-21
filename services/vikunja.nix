{
  services.vikunja = {
    enable = true;
    # Трафик будет проксироваться по HTTP
    frontendScheme = "http";
    frontendHostname = "todo.cherezov.xyz";
    port = 3456;
    settings = {
      service = {
        enableregistration = false;
        enableemailreminders = false;
      };
    };
  };
}
