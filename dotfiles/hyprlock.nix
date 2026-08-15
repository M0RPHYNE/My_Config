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
          path = "/home/morphyne/Pictures/Wallpaper/TON_L.jpeg";
          blur_passes = 0;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      shape = [
              # === 4 кружка NASA ===
              { size = "130, 130"; rounding = 65; border_size = 1; border_color = "rgba(255,255,255,0.2)"; color = "rgba(70,68,80,0.85) rgba(120,90,75,0.85) 135deg"; position = "1242, -120"; halign = "left"; valign = "top"; }
              { size = "130, 130"; rounding = 65; border_size = 1; border_color = "rgba(255,255,255,0.2)"; color = "rgba(120,90,75,0.85) rgba(150,100,60,0.85) 135deg"; position = "1386, -120"; halign = "left"; valign = "top"; }
              { size = "130, 130"; rounding = 65; border_size = 1; border_color = "rgba(255,255,255,0.2)"; color = "rgba(150,100,60,0.85) rgba(180,120,55,0.85) 135deg"; position = "1531, -120"; halign = "left"; valign = "top"; }
              { size = "130, 130"; rounding = 65; border_size = 1; border_color = "rgba(255,255,255,0.2)"; color = "rgba(180,120,55,0.85) rgba(214,150,70,0.85) 135deg"; position = "1675, -120"; halign = "left"; valign = "top"; }

              # === ВИЗУАЛ ПОЛЯ ПАРОЛЯ ===
              # Общая капсула (полупрозрачное матовое стекло)
              { size = "506, 135"; rounding = 67; border_size = 1; border_color = "rgba(255,255,255,0.4)"; color = "rgba(255,255,255,0.08)"; position = "1312, -776"; halign = "left"; valign = "top"; }
              # Кружок под иконку спутника (слева в капсуле)
              { size = "112, 112"; rounding = 56; border_size = 1; border_color = "rgba(255,255,255,0.4)"; color = "rgba(0,0,0,0)"; position = "1324, -788"; halign = "left"; valign = "top"; }
            ];

            input-field = [
                    {
                      size = "370, 135";
                      position = "1448, -776";
                      halign = "left";
                      valign = "top";

                      outer_color = "rgba(0,0,0,0)";
                      inner_color = "rgba(0,0,0,0)";
                      font_color = "rgb(255, 255, 255)";
                      check_color = "rgba(0,0,0,0)";
                      fail_color = "rgba(0,0,0,0)";

                      rounding = 67;
                      outline_thickness = 0;
                      font_family = "Nasalization";
                      placeholder_text = "Password";

                      # Убираем дерганье анимации перехода
                      fail_transition = 0;

                      # Делаем фейковые красные точки вместо надписи
                      # Символ '●' обычно используется для скрытого пароля
                      fail_text = "<span foreground='palevioletred'>● ● ● ● ●</span>";
                      fail_timeout = 2000;

                      fade_on_empty = false;
                      dots_center = true;
                      shadow_passes = 0;
                    }
                  ];

      # === Rust-сгенерированный виджет Mars Surface Temp (см. hyprlock-widgets.nix) ===
      # reload_cmd запускает бинарь, он перерисовывает PNG за ~8мс,
      # затем echo пути говорит hyprlock перечитать файл.
      image = [
        {
          path = "/home/morphyne/.cache/hyprlock/mars-temp.png";
          size = "300, 170";
          reload_time = 1; # секунд между перерисовкой
          reload_cmd = "$HOME/.local/bin/hyprlock-widgets mars-temp $HOME/.cache/hyprlock/mars-temp.png";
          rounding = 14;
          position = "0, -420";
          halign = "left";
          valign = "top";
        }
      ];

      label = [
              # Буквы NASA
              { text = "N"; font_size = 64; font_family = "Nasalization"; color = "rgba(255,255,255,1.0)"; position = "1269, -120"; halign = "left"; valign = "top"; }
              { text = "A"; font_size = 64; font_family = "Nasalization"; color = "rgba(255,255,255,1.0)"; position = "1418, -120"; halign = "left"; valign = "top"; }
              { text = "S"; font_size = 64; font_family = "Nasalization"; color = "rgba(255,255,255,1.0)"; position = "1564, -124"; halign = "left"; valign = "top"; }
              { text = "A"; font_size = 64; font_family = "Nasalization"; color = "rgba(255,255,255,1.0)"; position = "1706, -120"; halign = "left"; valign = "top"; }
        # Часы
        {
          text = "cmd[update:1000] echo \"<b>$(date +'%H:%M')</b>\"";
          font_size = 130;
          font_family = "Nasalization";
          color = "rgb(e0def4)";
          position = "78, -76";
          halign = "left";
          valign = "top";
          shadow_passes = 3;
          shadow_size = 4;
        }
        # День недели
        {
          text = "cmd[update:1000] echo \"$(LC_TIME=en_US.UTF-8 date +'%A' | tr 'a-z' 'A-Z')\"";
          font_size = 90;
          font_family = "Nasalization";
          color = "rgb(255, 255, 255)";
          position = "447, -373";
          halign = "left";
          valign = "top";
          shadow_passes = 2;
          shadow_size = 3;
        }
        # Дата
        {
          text = "cmd[update:1000] echo \"$(LC_TIME=en_US.UTF-8 date +'%d %B')\"";
          font_size = 60;
          font_family = "Nasalization";
          color = "rgb(255, 255, 255)";
          position = "903, -604";
          halign = "left";
          valign = "top";
          shadow_passes = 1;
        }
        # Иконка спутника
        {
          text = "🛰";
          font_size = 46;
          font_family = "JetBrainsMono Nerd Font";
          color = "rgba(255,255,255,0.8)";
          position = "1351, -815";
          halign = "left";
          valign = "top";
        }
      ];
    };
  };
}
