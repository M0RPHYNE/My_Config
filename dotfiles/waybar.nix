{ pkgs, ... }:

let
  powerStatus = pkgs.writeShellScriptBin "power-profile-status" ''
    profile=$(${pkgs.power-profiles-daemon}/bin/powerprofilesctl get)
    case "$profile" in
      power-saver)  icon="🌙"; text="Эко";    ;;
      balanced)     icon="⚖"; text="Баланс";  ;;
      performance)  icon="🚀"; text="Турбо";   ;;
      *)            icon="?"; text="$profile" ;;
    esac
    echo "{\"text\":\"$icon $text\",\"tooltip\":\"Режим питания: $profile\nКлик — переключить\",\"class\":\"$profile\"}"
  '';

  powerToggle = pkgs.writeShellScriptBin "power-profile-toggle" ''
    current=$(${pkgs.power-profiles-daemon}/bin/powerprofilesctl get)
    case "$current" in
      power-saver) next="balanced" ;;
      balanced)    next="performance" ;;
      performance) next="power-saver" ;;
      *)           next="balanced" ;;
    esac
    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set "$next"
  '';
in
{
  home.packages = [ powerStatus powerToggle ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        spacing = 4;
        modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
        modules-center = [ "clock" ];
        modules-right = [ "idle_inhibitor" "cpu" "memory" "custom/power" "pulseaudio" "network" "backlight" "battery" "tray" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          active-only = false;
          on-click = "activate";
          format = "{name}";
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        "clock" = {
          timezone = "Asia/Krasnoyarsk";
          format = "  {:%H:%M  |    %e %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip-format-activated = "Сон запрещён — клик, чтобы разрешить";
          tooltip-format-deactivated = "Сон разрешён — клик, чтобы запретить";
        };

        "cpu" = {
          interval = 5;
          format = " {usage}%";
          tooltip = false;
        };

        "memory" = {
          interval = 5;
          format = " {percentage}%";
          tooltip-format = "{used:0.1f}G / {total:0.1f}G";
        };

        "custom/power" = {
          exec = "power-profile-status";
          interval = 5;
          return-type = "json";
          on-click = "power-profile-toggle";
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [ "" "" "" "" "" ];
        };

        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = "  {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
          tooltip-format = "{ifname} via {gwaddr} ";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
      };
    };

    style = ''
      * {
          font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
          font-weight: bold;
      }

      window#waybar {
          background-color: rgba(35, 33, 54, 0.85);
          border-bottom: 2px solid rgba(156, 207, 216, 0.2);
          color: #e0def4;
          transition-property: background-color;
          transition-duration: .5s;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #6e6a86;
          border-bottom: 3px solid transparent;
          transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
          box-shadow: inherit;
          border-bottom: 3px solid #9ccfd8;
          color: #9ccfd8;
      }

      #workspaces button.active {
          color: #c4a7e7;
          border-bottom: 3px solid #c4a7e7;
      }

      #clock, #battery, #backlight, #network, #pulseaudio, #tray,
      #cpu, #memory, #idle_inhibitor, #custom-power {
          padding: 0 14px;
          margin: 4px 2px;
          color: #e0def4;
          background-color: rgba(42, 39, 63, 0.6);
          border-radius: 8px;
          transition: background-color 0.3s ease-in-out;
      }

      #clock, #battery, #backlight, #network, #pulseaudio, #tray,
      #cpu, #memory, #idle_inhibitor, #custom-power {
      }

      #clock:hover, #battery:hover, #backlight:hover, #network:hover,
      #pulseaudio:hover, #cpu:hover, #memory:hover, #idle_inhibitor:hover,
      #custom-power:hover {
          background-color: rgba(42, 39, 63, 0.9);
      }

      #clock {
          color: #f6c177;
          background-color: transparent;
          font-size: 14px;
      }

      #pulseaudio { color: #9ccfd8; }
      #network { color: #3e8fb0; }
      #backlight { color: #f6c177; }
      #battery { color: #eb6f92; }
      #cpu { color: #3e8fb0; }
      #memory { color: #c4a7e7; }
      #idle_inhibitor { color: #9ccfd8; }

      #idle_inhibitor.activated {
          color: #f6c177;
          background-color: rgba(246, 193, 119, 0.15);
      }

      #custom-power.power-saver  { color: #9ccfd8; }
      #custom-power.balanced     { color: #f6c177; }
      #custom-power.performance  { color: #eb6f92; }

      #battery.charging, #battery.plugged {
          color: #9ccfd8;
          background-color: rgba(42, 39, 63, 0.8);
      }

      #battery.critical:not(.charging) {
          background-color: #f38ba8;
          color: #11111b;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }
    '';
  };
}
