{ pkgs, ... }:

{
  home.packages = [ pkgs.power-profiles-daemon ];

  home.file.".local/bin/battery-monitor.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Нативный демон мониторинга батареи

      # Пробрасываем пути для PipeWire, чтобы работал звук в фоне
      export XDG_RUNTIME_DIR="/run/user/$(id -u)"

      BAT_PATH=$(find /sys/class/power_supply -name "BAT*" | head -n 1)

      if [ -z "$BAT_PATH" ]; then
        echo "Батарея не найдена. Демон завершает работу."
        exit 1
      fi

      LAST_NOTIFIED=100
      ECO_APPLIED=0

      while true; do
        capacity=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo 100)
        status=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")

        if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
          LAST_NOTIFIED=100
          ECO_APPLIED=0
        elif [ "$status" = "Discharging" ]; then

          if [ "$capacity" -le 10 ] && [ "$LAST_NOTIFIED" -gt 10 ]; then
            notify-send -u critical "Критический заряд: ''${capacity}%" "Срочно подключите зарядку!" -i battery-empty
            pw-play /run/current-system/sw/share/sounds/freedesktop/stereo/dialog-warning.oga 2>/dev/null || true
            LAST_NOTIFIED=10
          elif [ "$capacity" -le 15 ] && [ "$LAST_NOTIFIED" -gt 15 ]; then
            notify-send -u normal "Заряд батареи: ''${capacity}%" "Осталось мало заряда." -i battery-caution
            pw-play /run/current-system/sw/share/sounds/freedesktop/stereo/dialog-warning.oga 2>/dev/null || true
            LAST_NOTIFIED=15
          elif [ "$capacity" -le 30 ] && [ "$LAST_NOTIFIED" -gt 30 ]; then
            notify-send -u normal "Заряд батареи: ''${capacity}%" -i battery-caution
            LAST_NOTIFIED=30
          fi

          if [ "$capacity" -le 15 ] && [ "$ECO_APPLIED" -eq 0 ]; then
            powerprofilesctl set power-saver
            notify-send -u normal "Профиль питания" "Автоматически включён режим энергосбережения" -i power-profile-power-saver
            ECO_APPLIED=1
          fi

        fi

        sleep 60
      done
    '';
  };

  systemd.user.services.battery-monitor = {
    Unit = {
      Description = "Smart Battery Monitor Daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "%h/.local/bin/battery-monitor.sh";
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = "PATH=/run/current-system/sw/bin:${pkgs.libnotify}/bin:${pkgs.power-profiles-daemon}/bin";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
