{ pkgs, ... }:

{
  services.hyprpolkitagent.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "hyprlang";

    settings = {
      monitor = ",preferred,auto,1";
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";
      "$explorer" = "nautilus";

      "exec-once" = [
        "waypaper --restore"
        "hyprlock"
        "blueman-applet"
        "nm-applet --indicator"
        "waybar"
        "wl-paste --type text --watch clipsy store"
        "wl-paste --type image --watch clipsy store"
      ];

      general = {
        gaps_in = 6;
        gaps_out = 12;
        "border_size" = 2;
        "col.active_border" = "rgba(ffffffaa)";
        "col.inactive_border" = "rgba(1a1a1aaa)";
        layout = "dwindle";
      };


      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = true;
        };
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };
    };
    extraConfig = ''
      windowrule = match:class ^(dev\.morphyne\.clipsy)$, float on
      windowrule = match:class ^(dev\.morphyne\.clipsy)$, size 420 560
      windowrule = match:class ^(dev\.morphyne\.clipsy)$, pin on
    '';
  };
}
