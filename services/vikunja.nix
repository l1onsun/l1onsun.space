{
  services.vikunja = {
    enable = true;
    # Трафик будет проксироваться по HTTP
    frontendScheme = "http";
    frontendHostname = "todo.cherezov.xyz";
    port = 3456;
    settings = {
      service = {
        # Отключаем регистрацию новых пользователей (первый будет администратором)
        enableregistration = false;
        # Отключаем email-уведомления (при необходимости)
        enableemailreminders = false;
      };
    };
  };
}
