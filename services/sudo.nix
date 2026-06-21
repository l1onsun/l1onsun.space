{ pkgs, ... }:

{
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  environment.variables.SUDO_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
}
