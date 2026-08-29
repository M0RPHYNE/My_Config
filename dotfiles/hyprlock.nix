{ ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        grace = 0;
      };

      background = [
        {
          path = "/home/morphyne/Pictures/Wallpaper/TON_L.jpeg";
          blur_passes = 3;
          blur_size = 7;
          brightness = 0.75; # то же затемнение, что на SDDM
          contrast = 1.0;
          vibrancy = 0.0;
          noise = 0.0;
        }
      ];

      # Капсула пароля — тот же радиус/цвет surface, что у SilentSDDM
      input-field = [
        {
          size = "260, 44";
          halign = "center";
          valign = "center";
          position = "0, 40"; # чуть ниже центра, под часами

          outer_color = "rgba(38, 35, 58, 1.0)";   # overlay
          inner_color = "rgba(31, 29, 46, 0.85)";  # surface
          font_color = "rgb(224, 222, 244)";       # text
          check_color = "rgba(196, 167, 231, 0.6)"; # iris
          fail_color = "rgba(235, 111, 146, 0.6)";  # love

          rounding = 22;
          outline_thickness = 1;
          font_family = "JetBrainsMono Nerd Font";
          placeholder_text = "";
          fail_text = "";
          fail_timeout = 1500;

          fade_on_empty = true;
          dots_center = true;
          shadow_passes = 0;
        }
      ];

      label = [
        {
          text = "cmd[update:1000] echo \"$(date +'%H:%M')\"";
          font_size = 90;
          font_family = "Nasalization";
          color = "rgb(224, 222, 244)"; # text
          halign = "center";
          valign = "center";
          position = "0, -60";
        }
        {
          text = "cmd[update:60000] echo \"$(LC_TIME=en_US.UTF-8 date +'%A, %d %B')\"";
          font_size = 16;
          font_family = "Nasalization";
          color = "rgb(110, 106, 134)"; # muted
          halign = "center";
          valign = "center";
          position = "0, 10";
        }
      ];
    };
  };
}
