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
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      # === Поле для ввода пароля ===
      input-field = [
        {
          size = "280, 60";
          position = "0, -70";
          halign = "center";
          valign = "center";

          # Цвета Rosé Pine
          outer_color = "rgb(31748f)"; # pine
          inner_color = "rgb(1f1d2e)"; # surface
          font_color = "rgb(e0def4)";  # text

          # Цвета состояний
          check_color = "rgb(f6c177)"; # gold
          fail_color = "rgb(eb6f92)";  # love

          rounding = 20;
          outline_thickness = 2;

          # Строгий текст без курсива
          placeholder_text = "Password";
          fail_text = "Неверный пароль";

          fade_on_empty = false;
          dots_center = true;
          shadow_passes = 2;
        }
      ];

      # === Текстовые элементы ===
      label = [
        # 1. Часы
        {
          text = "cmd[update:1000] echo \"<b>$(date +'%H:%M')</b>\"";
          font_size = 110;
          font_family = "JetBrainsMono Nerd Font";
          color = "rgb(e0def4)"; # text
          position = "0, 200";
          halign = "center";
          valign = "center";
          shadow_passes = 3;
          shadow_size = 4;
        }
        # 2. Дата
        {
          text = "cmd[update:1000] echo \"$(date +'%A, %d %B')\"";
          font_size = 22;
          font_family = "JetBrainsMono Nerd Font";
          color = "rgb(c4a7e7)"; # iris
          position = "0, 80";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
        }
      ];
    };
  };
}
