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
      ", Print, exec, mkdir -p ~/Pictures/Screenshots && grimblast --notify copysave area ~/Pictures/Screenshots/screenshot-$(date +%F_%T).png"
      "SHIFT, Print, exec, mkdir -p ~/Pictures/Screenshots && grimblast --notify copysave screen ~/Pictures/Screenshots/screenshot-$(date +%F_%T).png"
    ];

    bindm = [
      # Перемещение и ресайз окон мышью
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

          ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"

          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
          "$mainMod, XF86Launch1, dpms, toggle"
        ];

        bindl = [
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];

  };
}
