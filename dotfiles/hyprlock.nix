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
          path = "/home/morphyne/Pictures/Wallpaper/home.jpeg";
          blur_passes = 3;
          blur_size = 8;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      shape = [
        # === Ряд из 5 кружков NASA (первый пустой) ===
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(c4a7e7)"; color = "rgba(0,0,0,0)"; position = "1098, -120"; halign = "left"; valign = "top"; }
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(c4a7e7)"; color = "rgba(0,0,0,0)"; position = "1242, -120"; halign = "left"; valign = "top"; }
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(c4a7e7)"; color = "rgba(0,0,0,0)"; position = "1386, -120"; halign = "left"; valign = "top"; }
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(c4a7e7)"; color = "rgba(0,0,0,0)"; position = "1531, -120"; halign = "left"; valign = "top"; }
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(c4a7e7)"; color = "rgba(0,0,0,0)"; position = "1675, -120"; halign = "left"; valign = "top"; }

        # === 2x2 кружки снизу слева: диагональ purple(декор)/muted(декор-кнопки) ===
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(c4a7e7)"; color = "rgba(196,167,231,0.15)"; position = "0, -699";  halign = "left"; valign = "top"; } # top-left purple, декор
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(6e6a86)"; color = "rgba(0,0,0,0)";           position = "139, -699"; halign = "left"; valign = "top"; } # top-right gray, декор "shutdown"
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(6e6a86)"; color = "rgba(0,0,0,0)";           position = "0, -844";  halign = "left"; valign = "top"; } # bottom-left gray, декор "reboot"
        { size = "130, 130"; rounding = 65; border_size = 3; border_color = "rgb(c4a7e7)"; color = "rgba(196,167,231,0.15)"; position = "139, -844"; halign = "left"; valign = "top"; } # bottom-right purple, декор

        # === Кружок-иконка внутри поля пароля ===
        { size = "112, 112"; rounding = 56; border_size = 2; border_color = "rgb(9ccfd8)"; color = "rgba(0,0,0,0)"; position = "1330, -788"; halign = "left"; valign = "top"; }
      ];

      input-field = [
        {
          size = "506, 135";
          position = "1312, -776";
          halign = "left";
          valign = "top";

          outer_color = "rgb(31748f) rgb(c4a7e7) rgb(9ccfd8) 45deg";
          inner_color = "rgba(31, 29, 46, 0.75)";
          font_color = "rgb(e0def4)";

          check_color = "rgb(f6c177)";
          fail_color = "rgb(eb6f92)";

          rounding = 67;
          outline_thickness = 3;

          font_family = "Nasalization";
          placeholder_text = "Password";
          fail_text = "Неверный пароль";

          fade_on_empty = false;
          dots_center = true;
          shadow_passes = 2;
        }
      ];

      label = [
        # Буквы N A S A внутри 4 крайних кружков ряда
        { text = "N"; font_size = 64; font_family = "Nasalization"; color = "rgb(e0def4)"; position = "1269, -120"; halign = "left"; valign = "top"; }
        { text = "A"; font_size = 64; font_family = "Nasalization"; color = "rgb(e0def4)"; position = "1418, -120"; halign = "left"; valign = "top"; }
        { text = "S"; font_size = 64; font_family = "Nasalization"; color = "rgb(e0def4)"; position = "1564, -124"; halign = "left"; valign = "top"; }
        { text = "A"; font_size = 64; font_family = "Nasalization"; color = "rgb(e0def4)"; position = "1706, -120"; halign = "left"; valign = "top"; }

        # Значки power/reboot (только визуал, не кликабельны)
        { text = "⏻"; font_size = 40; font_family = "JetBrainsMono Nerd Font"; color = "rgb(9ccfd8)"; position = "50, -736"; halign = "left"; valign = "top"; }
        { text = "⟲"; font_size = 40; font_family = "JetBrainsMono Nerd Font"; color = "rgb(9ccfd8)"; position = "50, -881"; halign = "left"; valign = "top"; }

        # Часы — крупно, верх-лево
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
        # SUNDAY — день недели, под часами
        {
          text = "cmd[update:1000] echo \"$(LC_TIME=en_US.UTF-8 date +'%A' | tr 'a-z' 'A-Z')\"";
          font_size = 90;
          font_family = "Nasalization";
          color = "rgb(9ccfd8)";
          position = "447, -373";
          halign = "left";
          valign = "top";
          shadow_passes = 2;
          shadow_size = 3;
        }
        # 12 July — дата, центр экрана
        {
          text = "cmd[update:1000] echo \"$(LC_TIME=en_US.UTF-8 date +'%d %B')\"";
          font_size = 60;
          font_family = "Nasalization";
          color = "rgb(c4a7e7)";
          position = "903, -604";
          halign = "left";
          valign = "top";
          shadow_passes = 1;
        }
      ];
    };
  };
}
