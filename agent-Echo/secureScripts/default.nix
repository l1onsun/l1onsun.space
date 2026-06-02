{
  security.sudo.extraRules = [
    {
      # Кому разрешено
      users = [ "user1" ];
      # От имени кого выполняются команды
      runAs = "user2";
      # Список разрешённых команд (полные пути!)
      commands = [
        {
          # Ссылка на скрипт — путь будет подставлен из Nix store
          command = "${mySecureScripts}/bin/my-task *";
          options = [ "NOPASSWD" ];  # не запрашивать пароль
        }
      ];
    }
  ];
}
