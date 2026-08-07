{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        # Отступы для эффекта "парения"
        margin = "10 20 0 20";
        spacing = 10;

        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        # Убрали custom/lock из правой части
        modules-right = [
          "idle_inhibitor"
          "power-profiles-daemon"
          "backlight"
          "network"
          "pulseaudio"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            active = "";
            default = "";
            empty = "";
          };
          persistent-workspaces = {
            "*" = 4;
          };
        };

        "hyprland/window" = {
          # Отображаем имя приложения (класс), а не имя файла/вкладки
          format = "{class}";
          max-length = 50;
          rewrite = {
            "" = "Hyprland";          # Если окна нет
            "kitty" = "Kitty";
            "firefox-nightly" = "Firefox";
            "firefox" = "Firefox";
            "discord" = "Discord";
            "dev.zed.Zed" = "Zed Editor";
            "org.gnome.Nautilus" = "Nautilus";
            "com.follow.clash" = "FlClash";
            "net.lutris.Lutris" = "Lutris";
            ".blueman-manager-wrapped" = "Bluetooth";
            "org.telegram.desktop" = "Telegram";
            "waypaper" = "Waypaper";
          };
        };

        "clock" = {
          # Время без значка часов
          format = "{:%H:%M}";
          format-alt = "  {:%A, %d %B}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        # ☕ Модуль запрета сна (кофе)
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip-format-activated = "Сон отключен";
          tooltip-format-deactivated = "Обычный режим сна";
        };

        #  Модуль профилей питания
        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "Профиль: {profile}\nДрайвер: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        # 󰃠 Модуль яркости экрана
        "backlight" = {
          format = "{icon}  {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃠"];
          on-scroll-up = "brightnessctl set 1%+";
          on-scroll-down = "brightnessctl set 1%-";
        };

        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  Wired";
          format-disconnected = "󰤭  Offline";
          tooltip-format = "{ipaddr}/{cidr}";
        };

        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-muted = "󰖁  Muted";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "  {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };
      };
    };

    style = ''
      /* === Палитра Rosé Pine === */
      @define-color base #191724;
      @define-color surface #1f1d2e;
      @define-color overlay #26233a;
      @define-color muted #6e6a86;
      @define-color text #e0def4;
      @define-color love #eb6f92;
      @define-color gold #f6c177;
      @define-color rose #ebbcba;
      @define-color pine #31748f;
      @define-color foam #9ccfd8;
      @define-color iris #c4a7e7;

      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 14px;
        font-weight: bold;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        color: @text;
      }

      .modules-left, .modules-center, .modules-right {
        background-color: @base;
        border-radius: 20px;
        padding: 4px 12px;
        border: 2px solid @surface;
      }

      #workspaces button {
        color: @muted;
        padding: 0 6px;
        background: transparent;
        transition: color 0.2s ease;
      }
      #workspaces button.active {
        color: @rose;
      }
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: @iris;
      }

      #clock, #battery, #pulseaudio, #network, #tray, #window,
      #idle_inhibitor, #power-profiles-daemon, #backlight {
        padding: 4px 10px;
        color: @text;
      }

      /* === Раскраска === */
      #clock { color: @text; }
      #backlight { color: @gold; }
      #power-profiles-daemon { color: @pine; }

      #idle_inhibitor.activated { color: @rose; }
      #idle_inhibitor.deactivated { color: @muted; }

      #pulseaudio { color: @iris; }
      #network { color: @foam; }

      #battery { color: @pine; }
      #battery.charging, #battery.plugged { color: @rose; }
      #battery.warning:not(.charging) { color: @gold; }
      #battery.critical:not(.charging) {
        color: @love;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to { color: @text; }
      }
    '';
  };
}
