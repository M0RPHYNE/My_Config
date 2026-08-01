{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bind = [

      "$mainMod, M, exit"
      "$mainMod, C, killactive"
      "$mainMod, R, exec, $menu"
      "$mainMod, F, fullscreen, 0"


      "$mainMod, Q, exec, $terminal"
      "$mainMod, E, exec, $explorer --new-window"
      "$mainMod, T, exec, missioncenter"
      "$mainMod, S, exec, steam"
      "$mainMod, Z, exec, zeditor"
      "$mainMod, O, exec, obsidian"
      "$mainMod, G, exec, lutris"
      "$mainMod, V, exec, clipsy"

      "ALT, 1, exec, firefox"
      "ALT, 2, exec, flclash"




      # Фокус окон
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Рабочие столы
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"

      # Перенос окон
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"

      # Скролл рабочих столов мышкой
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      #Longscrin
      "$mainMod, L, exec, hyprlock"


      # Скриншоты
      ", Print, exec, mkdir -p ~/Pictures/Screenshots && grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/screenshot-$(date +%F_%T).png | wl-copy && notify-send \"Скриншот сохранён и скопирован\" -i camera-photo"
      "SHIFT, Print, exec, mkdir -p ~/Pictures/Screenshots && grim - | tee ~/Pictures/Screenshots/screenshot-$(date +%F_%T).png | wl-copy && notify-send \"Полный скриншот сохранён и скопирован\" -i camera-photo"
    ];

    bindm = [
      # Перемещение и ресайз окон мышью
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
      ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"

      ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
      ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"

      ",XF86AudioPlay, exec, playerctl play-pause && swayosd-client --play-pause"
      ",XF86AudioPause, exec, playerctl play-pause && swayosd-client --play-pause"
      ",XF86AudioNext, exec, playerctl next && swayosd-client --skip-next"
      ",XF86AudioPrev, exec, playerctl previous && swayosd-client --skip-prev"
    ];

    bindl = [
      ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ",XF86AudioMicMute, exec, swayosd-client --default-source mute-toggle"
    ];

  };
}
