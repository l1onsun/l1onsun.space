{pkgs, ...}: {
  hardware.i2c.enable = true;
  environment.systemPackages = [ pkgs.ddcutil ];
  # Usage:
  # low brightness:
  # > ddcutil setvcp 10 0
  # max brightness:
  # > ddcutil setvcp 10 100
  # get current / max:
  # > ddcutil getvcp 10
}
