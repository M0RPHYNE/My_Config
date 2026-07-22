{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    # Настройки в удобном Nix-формате
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11.0;
    };
    
    settings = {
      disable_ligatures = "never";
      
      # Курсор
      cursor_shape = "beam";
      cursor_beam_thickness = "1.5";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";
      
      # Скроллинг
      scrollback_lines = 10000;
      wheel_scroll_multiplier = "5.0";
      touch_scroll_multiplier = "1.0";
      
      # Мышь
      mouse_hide_wait = "3.0";
      url_style = "curly";
      detect_urls = "yes";
      copy_on_select = "yes";
      
      # Производительность
      repaint_delay = 10;
      input_delay = 1;
      sync_to_monitor = "yes";
      
      # Окно и прозрачность
      remember_window_size = "yes";
      initial_window_width = 640;
      initial_window_height = 400;
      window_padding_width = 12;
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;
      background_opacity = "0.92";
      background_blur = 32;
      dynamic_background_opacity = "yes";
      
      # Цветовая схема: Rosé Pine Moon
      foreground = "#e0def4";
      background = "#232136";
      selection_foreground = "#e0def4";
      selection_background = "#44415a";
      cursor = "#9ccfd8";
      cursor_text_color = "#232136";
      
      # Цвета терминала
      color0 = "#393552"; color8 = "#6e6a86";
      color1 = "#eb6f92"; color9 = "#eb6f92";
      color2 = "#9ccfd8"; color10 = "#9ccfd8";
      color3 = "#f6c177"; color11 = "#f6c177";
      color4 = "#3e8fb0"; color12 = "#3e8fb0";
      color5 = "#c4a7e7"; color13 = "#c4a7e7";
      color6 = "#9ccfd8"; color14 = "#9ccfd8";
      color7 = "#e0def4"; color15 = "#e0def4";
      
      # Вкладки
      tab_bar_edge = "top";
      tab_bar_style = "fade";
      tab_fade = "0.25 0.5 0.75 1";
      active_tab_foreground = "#9ccfd8";
      active_tab_background = "#2a273f";
      inactive_tab_foreground = "#6e6a86";
      inactive_tab_background = "#232136";
      
      # Дополнительно
      enable_audio_bell = "no";
      linux_display_server = "wayland";
      wayland_titlebar_color = "background";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      shell = "${pkgs.zsh}/bin/zsh"; # Сразу жестко линкуем к Zsh в Nix
    };


    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";      
      "ctrl+t" = "new_tab";
      "ctrl+w" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+equal" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
      "ctrl+shift+backspace" = "change_font_size all 0";
    };
  };
}
