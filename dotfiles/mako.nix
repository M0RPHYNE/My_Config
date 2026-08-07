{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      font = "JetBrainsMono Nerd Font 11";
      width = 350;
      height = 120;
      margin = "16,16,0,0";
      padding = "14";
      border-size = 2;
      border-radius = 12;
      icons = true;
      max-icon-size = 48;
      default-timeout = 5000;
      ignore-timeout = false;
      layer = "overlay";
      anchor = "top-right";

      # группировка одинаковых уведомлений (например спам от Steam/Discord)
      group-by = "app-name";
      max-visible = 5;
      sort = "-time";

      # базовая палитра — используется как fallback для normal/low
      background-color = "#2a273fd9";
      text-color = "#e0def4";
      border-color = "#9ccfd8cc";
      progress-color = "#9ccfd8";
    };

    extraConfig = ''
      [urgency=low]
      border-color=#6e6a86cc
      default-timeout=3000

      [urgency=critical]
      border-color=#eb6f92cc
      default-timeout=0
      ignore-timeout=true
    '';
  };
}
