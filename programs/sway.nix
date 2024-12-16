{ pkgs, lib, config, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "alacritty"; 
      startup = [
        {command = "swaync";}
      ];
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+tab" = "workspace back_and_forth";
        "${modifier}+n" = "exec swaync-client -t -sw";
        "XF86MonBrightnessDown" = "exec light -U 5";
        "XF86MonBrightnessUp" = "exec light -A 5";
      };
      bars = [{
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
      }];
      input."type:touchpad" = {
        accel_profile = "flat";
        tap = "enabled";
        natural_scroll = "enabled";
        drag = "disabled";
        # drag_lock disabled;
        middle_emulation = "enabled";
        pointer_accel = "1";
        # calibration_matrix 5.0 0 0 0 5.0 0
      };
      input."type:keyboard" = {
        xkb_layout = "us,ru";
        xkb_options = "grp:alt_shift_toggle";
        repeat_delay = "180";
        repeat_rate = "30";
      };

      window = {
        hideEdgeBorders = "smart";
        titlebar = false;
        border = 3;
      };
    };
    # input "1118:2083:Microsoft_Microsoft___Classic_IntelliMouse__" {
    # 	accel_profile "flat"
    # 	pointer_accel 0.6
    # 	# calibration_matrix 5.0 0 0 0 5.0 0
    # }
  };


  home.packages = [
    pkgs.swaynotificationcenter
  ];
  programs.i3status-rust = {
    enable = true;
  };
}
