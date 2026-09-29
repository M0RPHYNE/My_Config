{ config, pkgs, unstable, ... }:

{
  imports = [
    ./dotfiles/battery.nix
    ./dotfiles/binds.nix
    ./dotfiles/fastfetch.nix
    ./dotfiles/hypridle.nix
    ./dotfiles/hyprland.nix
    ./dotfiles/hyprlock.nix
    ./dotfiles/kitty.nix
    ./dotfiles/mako.nix
    ./dotfiles/nautilus.nix
    ./dotfiles/waybar.nix
    ./dotfiles/wofi.nix
    ./dotfiles/zsh.nix
  ];

  ##############################################################
  # Пользователь
  ##############################################################
  home.username = "morphyne";
  home.homeDirectory = "/home/morphyne";
  home.stateVersion = "25.11";

  ##############################################################
  # Шрифты
  ##############################################################
  fonts.fontconfig.enable = true;
  home.file.".local/share/fonts/AstroSpace.otf".source = ./fonts/AstroSpace.otf;
  home.file.".local/share/fonts/Nasalization.otf".source = ./fonts/Nasalization.otf;

  ##############################################################
  # Пользовательские пакеты
  ##############################################################
  home.packages = with pkgs; [
    # --- Свои сборки и обёртки ---
    (pkgs.callPackage /home/morphyne/Documents/clipsy { })
    (pkgs.writeShellScriptBin "firefox" ''exec /home/morphyne/Applications/FirefoxNightly/firefox "$@"'')
    (pkgs.writeShellScriptBin "flclash" ''exec /home/morphyne/Applications/FlClash/FlClash "$@"'')
    (pkgs.writeShellScriptBin "happ" ''exec /home/morphyne/Applications/Happ/opt/happ/bin/Happ "$@"'')

    # --- Системные библиотеки, схемы и звуки ---
    gsettings-desktop-schemas
    libcanberra-gtk3
    sound-theme-freedesktop

    # --- Wayland / рабочее окружение ---
    brightnessctl
    grim
    grimblast
    libnotify
    playerctl
    slurp
    wl-clipboard
    wofi

    # --- Графика и медиа ---
    imv
    krita
    mpv
    mpvpaper

    # --- Офис, заметки и словари ---
    hunspell
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    libreoffice-fresh
    obsidian

    # --- Разработка ---
    nixd
    zed-editor

    # --- Системные утилиты ---
    gnome-calculator
    gnome-clocks
    mission-center
    nautilus

    # --- Сеть и интернет ---
    qbittorrent
    termius

    # --- Игры ---
    lutris
  ];

  ##############################################################
  # MangoHud
  ##############################################################
  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      cpu_stats = true;
      fps_limit = 0;
      frame_timing = true;
      gpu_stats = true;
      position = "top-left";
      ram = true;
      vram = true;
    };
  };

  ##############################################################
  # Переменные окружения сессии
  ##############################################################
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/glib-2.0/schemas:${pkgs.gtk3}/share/glib-2.0/schemas";
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
  };

  ##############################################################
  # Сервисы
  ##############################################################
  programs.home-manager.enable = true;
  services.playerctld.enable = true;
}
