{pkgs, ...}: {
  services.udev = {
    packages = [
      pkgs.vial
    ];
  };
  environment.systemPackages = [
     pkgs.qmk
     pkgs.vial
  ];
  hardware.keyboard.qmk.enable = true;
}
