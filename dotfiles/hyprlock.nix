{ ... }:

{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        grace = 0;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          noise = 0.02;
          contrast = 0.9;
          brightness = 0.7;
        }
      ];

      # Поле для ввода пароля
      input-field = [
        {
          size = "300, 60";
          position = "0, -20";
          halign = "center";
          valign = "center";

          outer_color = "rgb(9ccfd8)";
          inner_color = "rgb(2a273f)";
          font_color = "rgb(e0def4)";

          rounding = 16;
          outline_thickness = 2;
          placeholder_text = "Пароль...";
          fade_on_empty = false;

          check_color = "rgb(9ccfd8)";
          fail_color = "rgb(eb6f92)";
          fail_text = "Неверный пароль";
        }
      ];

      # Часы
      label = [
        {
          text = "cmd[update:1000] echo \"$(date +'%H:%M')\"";
          font_size = 90;
          font_family = "JetBrainsMono Nerd Font";
          color = "rgb(e0def4)";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo \"$(date +'%A, %d %B')\"";
          font_size = 20;
          font_family = "JetBrainsMono Nerd Font";
          color = "rgb(9ccfd8)";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
