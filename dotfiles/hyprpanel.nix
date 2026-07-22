{ ... }:

{
  programs.hyprpanel = {
    enable = true;

    settings = {
      layout.bar.layouts = {
        "0" = {
          left = [ "workspaces" ];
          middle = [ "clock" ];
          right = [ "volume" "network" "bluetooth" "battery" "systray" ];
        };
      };

      bar.workspaces = {
        show_icons = false;      # нам нужны именно номера в кружках, как на скетче
        numbered_active_indicator = "solid";
      };

      bar.launcher.autoDetectIcon = true;

      menus.clock = {
        time.military = true;
        weather.enabled = false;   # включи, если хочешь погоду в попапе календаря
      };

      menus.battery = {
        # включает выбор пресета питания прямо в попапе батареи
        enableProfileControl = true;
      };

      theme.bar = {
        transparent = false;
        background = "rgba(35, 33, 54, 0.85)";
        border.color = "rgba(156, 207, 216, 0.2)";
      };

      theme.font = {
        name = "JetBrainsMono Nerd Font";
        size = "13px";
      };

      # Цвета под общую Rosé Pine Moon тему
      theme.bar.buttons.modules = {
        battery.enabled.text = "#e0def4";
        volume.enabled.text = "#9ccfd8";
        network.enabled.text = "#3e8fb0";
        bluetooth.enabled.text = "#c4a7e7";
        clock.text = "#f6c177";
      };
    };
  };
}
