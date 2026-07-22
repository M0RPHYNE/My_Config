{ ... }:

{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;                     # 5 минут бездействия — блокировка
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;                     # ещё через 30 сек — гасим экран
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;                    # 30 минут — сон ноутбука
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
