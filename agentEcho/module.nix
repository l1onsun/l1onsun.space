{ pkgs, lib, ... }:

{
  users.users.agentEcho = {
    isNormalUser = true;
    homeMode = "750";
    description = "agentEcho";
    extraGroups = [ ];
    hashedPassword = "$6$gIYA0nZas/XBRi03$xD0gJstsT9AwYsvnZkaaQaPn.B/Pswt4DqKZcYv/tNDtxUvJq9T5rGYUwyNPU0D8SFdOOPHZdD0fc23/JW0ER1";
    shell = pkgs.fish;
  };

  security.pam.services.su.rules.auth = {
    # Правило 1: Проверяем целевого пользователя (в которого входят).
    # Если это agentEcho, игнорируем правило и идем к следующему (success=ignore).
    # Если нет, пропускаем следующее правило (default=1), чтобы не давать wheel бесправный su.
    check_target_user = {
      order = 100; # Чем меньше число, тем выше правило в итоговом файле PAM
      modulePath = "pam_succeed_if.so";
      control = "[success=ignore default=1]";
      args = [ "user" "=" "agentEcho" ];
    };

    # Правило 2: Проверяем, что текущий пользователь в группе wheel.
    # Если да, этого достаточно (sufficient) — пароль не запрашивается.
    # Если нет, просто идем дальше к стандартным правилам PAM.
    check_wheel_group = {
      order = 101; # Должно идти сразу после первого правила
      modulePath = "pam_succeed_if.so";
      control = "sufficient";
      args = [ "use_uid" "user" "ingroup" "wheel" ];
    };
  };
}
