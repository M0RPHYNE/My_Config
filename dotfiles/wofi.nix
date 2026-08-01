{ ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      width = 850;      # Сделали окно чуть шире для плит
      height = 550;
      show = "drun";
      prompt = "Поиск приложений...";
      allow_images = true;
      insensitive = true;
      hide_scroll = true; # Скрываем скроллбар, в плиточном дизайне он обычно мешает
      no_actions = true;
      halign = "center";
      valign = "center";
      content_halign = "fill";
      layer = "overlay";
      term = "kitty";
      filter_rate = 100;
      hide_search = false;

      # === Настройки сетки ===
      columns = 4;      # Делаем 4 колонки
      image_size = 52;  # Увеличиваем иконки для плит
      location = "center";
      matching = "fuzzy";
    };

    style = ''
      /* === Rosé Pine Theme (Grid Layout) === */
      * {
          font-family: "JetBrainsMono Nerd Font", sans-serif;
          font-size: 14px;
      }

      window {
          background-color: rgba(25, 23, 36, 0.95);
          border: 2px solid rgba(49, 116, 143, 0.5);
          border-radius: 24px;
          padding: 0;
          box-shadow: 0 16px 48px rgba(0, 0, 0, 0.6);
      }

      #input {
          margin: 24px 24px 16px 24px;
          padding: 16px 20px;
          border: none;
          background-color: rgba(31, 29, 46, 0.8);
          color: #e0def4;
          border-radius: 16px;
          font-size: 16px;
          font-weight: bold;
          transition: all 0.3s ease;
          outline: none;
      }

      #input:focus {
          background-color: rgba(38, 35, 58, 0.9);
          box-shadow: 0 0 0 2px rgba(156, 207, 216, 0.6);
      }

      #input placeholder {
          color: #6e6a86;
      }

      #inner-box {
          margin: 0 16px 16px 16px;
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
          padding: 0;
      }

      /* === Дизайн плит === */
      #entry {
          padding: 12px;
          margin: 8px;
          border-radius: 18px;
          /* Делаем каждую плитку слегка выделяющейся */
          background-color: rgba(31, 29, 46, 0.4);
          transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
      }

      #entry:selected {
          /* Яркий градиент при наведении */
          background: linear-gradient(135deg, rgba(49, 116, 143, 0.6) 0%, rgba(196, 167, 231, 0.3) 100%);
          border-radius: 18px;
          outline: none;
      }

      #entry:hover {
          background-color: rgba(110, 106, 134, 0.15);
      }

      #entry image {
          margin-right: 12px;
          padding: 10px;
          border-radius: 14px;
          background-color: rgba(38, 35, 58, 0.6);
          min-width: 52px;
          min-height: 52px;
      }

      #entry:selected image {
          background-color: rgba(156, 207, 216, 0.25);
      }

      #text {
          margin: 0;
          padding: 0;
          color: #e0def4;
          font-weight: 500;
      }

      #text:selected {
          color: #9ccfd8;
          font-weight: bold;
      }
    '';
  };
}
