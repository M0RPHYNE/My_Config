{ ... }:

{
  services.mako = {
    enable = true;
    
    # Современный синтаксис через блок settings
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
      layer = "overlay";
      anchor = "top-right";

      # Цветовая схема Rosé Pine Moon (как в твоем оригинале)
      background-color = "#2a273fd9"; # Прозрачность 85%
      text-color = "#e0def4";
      border-color = "#9ccfd8cc";
      progress-color = "#9ccfd8";
    };

    # Правила для уровней срочности (они пишутся отдельно)
    extraConfig = ''
      [urgency=low]
      border-color=#9ccfd8cc
      background-color=#2a273fd9
      text-color=#e0def4
      default-timeout=4000

      [urgency=normal]
      border-color=#9ccfd8cc
      background-color=#2a273fd9
      text-color=#e0def4
      default-timeout=4000

      [urgency=critical]
      border-color=#6e6a86cc
      background-color=#2a273fd9
      text-color=#e0def4
      default-timeout=6000
    '';
  };
}
