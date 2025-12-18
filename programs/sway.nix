{ bar_font_size }:
{
  pkgs,
  lib,
  config,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      startup = [
        { command = "swaync"; }
      ];
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+tab" = "workspace back_and_forth";
          "${modifier}+n" = "exec swaync-client -t -sw";
          "${modifier}+Shift+Return" = "exec ${pkgs.alacritty} -e fish -C 'my/gits/l1onsun.space/; onefetch'";
          "XF86MonBrightnessDown" = "exec light -U 5";
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.04+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.04-";
          "XF86AudioMute" = " exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = " exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86TouchpadToggle" = "input type:touchpad events toggle enabled disabled";
          # bindsym XF86AudioPlay exec playerctl play-pause
          # bindsym XF86AudioNext exec playerctl next
          # bindsym XF86AudioPrev exec playerctl previous
          # bindsym XF86Search exec bemenu-run
        };
      bars = [
        {
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs config-default.toml";
          position = "top";
          fonts.size = bar_font_size;
        }
      ];
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
        xkb_options = "grp:alt_shift_toggle,caps:swayescape";
        repeat_delay = "180";
        repeat_rate = "30";
      };
      input."type:mouse" = {
        accel_profile = "flat";
        pointer_accel = "0.6";
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
    pkgs.swaykbdd
  ];

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 54.72;
    longitude = 20.51;
  };
  programs.i3status-rust = {
    enable = true;
    bars.default = {
      theme = "plain";
      icons = "awesome5";
      blocks = [
        {
          block = "time";
          interval = 5;
          format = " $timestamp.datetime(f:'%R') ";
        }
        {
          block = "net";
          device = "wlan0";
          format = "$ssid $signal_strength $ip $graph_down $speed_down";
          interval = 5;
        }
        {
          block = "battery";
        }
        {
          block = "keyboard_layout";
          driver = "sway";
        }
        {
          block = "hueshift";
          hue_shifter = "gammastep";
          step = 50;
          click_temp = 4000;
        }
        {
          block = "load";
          interval = 1;
          format = "$1m";
        }
        {
          block = "sound";
        }
        {
          block = "time";
          interval = 60;
          format = " $timestamp.datetime(f:'%a %d') ";
        }
      ];
    };
  };

  services.swayidle =
    let
      # lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
      lock = "${pkgs.swaylock}/bin/swaylock";
      display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
    in
    {
      enable = false;
      timeouts = [
        {
          timeout = 15; # in seconds
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
        }
        {
          timeout = 20;
          command = lock;
        }
        {
          timeout = 25;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 30;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          # adding duplicated entries for the same event may not work
          command = (display "off") + "; " + lock;
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = (display "off") + "; " + lock;
        }
        {
          event = "unlock";
          command = display "on";
        }
      ];
    };
  programs.swaylock.enable = true;
}
