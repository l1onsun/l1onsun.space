# Example to create a bios compatible gpt partition
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/vda";  # main disk device
      content = {
        type = "gpt";
        partitions = {
          bios = {
            size = "1M";
            type = "EF02";  # BIOS boot partition for GRUB
          };
          root = {
            size = "100%";
            type = "8300";  # Linux filesystem
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
