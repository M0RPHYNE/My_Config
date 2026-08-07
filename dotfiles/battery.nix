{ pkgs, ... }:

{
  home.packages = [ pkgs.power-profiles-daemon ]; # даёт powerprofilesctl

  home.file.".local/bin/battery-monitor.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      BAT="/sys/class/power_supply/BAT0"
      STATE_DIR="''${XDG_RUNTIME_DIR:-/tmp}/battery-monitor"
      mkdir -p "$STATE_DIR"
      NOTIFIED_FILE="$STATE_DIR/last_notified"
      PROFILE_FILE="$STATE_DIR/eco_applied"

      [ -f "$BAT/capacity" ] || exit 0
      capacity=$(cat "$BAT/capacity")
      status=$(cat "$BAT/status")

      # Если заряжается или полностью заряжен — сбрасываем состояние
      if [ "$status" != "Discharging" ]; then
        rm -f "$NOTIFIED_FILE" "$PROFILE_FILE"
        exit 0
      fi

      last_notified=$(cat "$NOTIFIED_FILE" 2>/dev/null || echo 100)

      # Находим самый низкий (самый критичный) достигнутый порог
      threshold=100
      for t in 20 15 10 5; do
        if [ "$capacity" -le "$t" ]; then
          threshold=$t
        fi
      done

      if [ "$threshold" -lt 100 ] && [ "$threshold" -lt "$last_notified" ]; then
        urgency="normal"
        [ "$threshold" -le 10 ] && urgency="critical"
        notify-send -u "$urgency" "Заряд батареи: ''${capacity}%" -i battery-caution
        pw-play /run/current-system/sw/share/sounds/freedesktop/stereo/dialog-warning.oga 2>/dev/null || true
        echo "$threshold" > "$NOTIFIED_FILE"
      fi

      # Авто-переключение на эко-профиль при 15% и ниже
      if [ "$capacity" -le 15 ] && [ ! -f "$PROFILE_FILE" ]; then
        powerprofilesctl set power-saver
        touch "$PROFILE_FILE"
        notify-send -u normal "Профиль питания" "Автоматически включён режим энергосбережения" -i power-profile-power-saver
      fi
    '';
  };

  systemd.user.services.battery-monitor = {
    Unit = { Description = "Проверка заряда батареи и уведомления"; };
    Service = {
      Type = "oneshot";
      ExecStart = "%h/.local/bin/battery-monitor.sh";
    };
  };

  systemd.user.timers.battery-monitor = {
    Unit = { Description = "Таймер проверки батареи"; };
    Timer = {
      OnBootSec = "10s";
      OnUnitActiveSec = "30s";
      Persistent = true;
    };
    Install = { WantedBy = [ "timers.target" ]; };
  };
}
