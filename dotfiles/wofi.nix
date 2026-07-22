{ ... }:

{
  programs.wofi = {
    enable = true;
    
    # Переносим настройки из config_wofi
    settings = {
      width = 800;
      height = 600;
      show = "drun";
      prompt = "Search";
      allow_images = true;
      insensitive = true;
      hide_scroll = false;
      no_actions = true;
      halign = "center";
      valign = "center";
      content_halign = "fill";
      layer = "overlay";
      term = "kitty";
      filter_rate = 100;
      hide_search = false;
      columns = 1;
      location = "center";
      matching = "fuzzy";
      image_size = 48;
    };

    # Вклеиваем твой CSS из style_wofi.css напрямую
    style = ''
      * {
          font-family: "JetBrainsMono Nerd Font", sans-serif;
          font-size: 14px;
      }

      window {
          background-color: rgba(35, 33, 54, 0.85);
          border: 1px solid rgba(156, 207, 216, 0.3);
          border-radius: 24px;
          padding: 0;
          box-shadow: 0 16px 48px rgba(0, 0, 0, 0.6);
          backdrop-filter: blur(32px);
      }

      #input {
          margin: 20px 20px 16px 20px;
          padding: 16px 20px;
          border: none;
          background-color: rgba(42, 39, 63, 0.6);
          color: #e0def4;
          border-radius: 16px;
          font-size: 15px;
          font-weight: 400;
          transition: all 0.3s ease;
          outline: none;
      }

      #input:focus {
          background-color: rgba(42, 39, 63, 0.8);
          box-shadow: 0 0 0 2px rgba(156, 207, 216, 0.4);
      }

      #input placeholder {
          color: #6e6a86;
      }

      #inner-box {
          margin: 0 12px 12px 12px;
          padding: 0;
          background-color: transparent;
      }

      #outer-box {
          margin: 0;
          padding: 0;
          background-color: transparent;
      }

      #scroll {
          margin: 0;
          padding: 8px;
      }

      #text {
          margin: 0;
          padding: 0;
          color: #e0def4;
          font-weight: 400;
      }

      #entry {
          padding: 14px 18px;
          margin: 6px 8px;
          border-radius: 14px;
          background-color: transparent;
          transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
      }

      #entry:selected {
          background: linear-gradient(135deg, 
                      rgba(156, 207, 216, 0.15) 0%, 
                      rgba(196, 167, 231, 0.1) 100%);
          color: #9ccfd8;
          transform: scale(1.02);
      }

      #entry:hover {
          background-color: rgba(110, 106, 134, 0.12);
          transform: translateX(2px);
      }

      #entry image {
          margin-right: 16px;
          padding: 8px;
          border-radius: 12px;
          background-color: rgba(110, 106, 134, 0.15);
          min-width: 48px;
          min-height: 48px;
      }

      #entry:selected image {
          background: linear-gradient(135deg, 
                      rgba(156, 207, 216, 0.25) 0%, 
                      rgba(196, 167, 231, 0.2) 100%);
      }

      #text:selected {
          color: #9ccfd8;
          font-weight: 500;
      }

      scrollbar {
          background-color: transparent;
          width: 6px;
      }

      scrollbar slider {
          background-color: rgba(156, 207, 216, 0.25);
          border-radius: 8px;
          min-height: 40px;
      }

      scrollbar slider:hover {
          background-color: rgba(156, 207, 216, 0.4);
      }

      scrollbar trough {
          background-color: transparent;
      }
    '';
  };
}
