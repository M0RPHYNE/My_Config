{ config, pkgs, ... }:

{
  imports = [
    ./dotfiles/hyprland.nix
    ./dotfiles/binds.nix
    ./dotfiles/kitty.nix
    ./dotfiles/zsh.nix
    ./dotfiles/wofi.nix
    ./dotfiles/mako.nix
    ./dotfiles/hypridle.nix
    ./dotfiles/hyprlock.nix
    ./dotfiles/waybar.nix
    ./dotfiles/fastfetch.nix
    ./dotfiles/nautilus.nix
    ./dotfiles/battery.nix
  ];

  home.file.".local/share/fonts/AstroSpace.otf".source = ./fonts/AstroSpace.otf;
  home.file.".local/share/fonts/Nasalization.otf".source = ./fonts/Nasalization.otf;
  fonts.fontconfig.enable = true;

  home.username = "morphyne";
  home.homeDirectory = "/home/morphyne";
  home.stateVersion = "25.11";

  ##############################################################
  # Пользовательские пакеты
  ##############################################################
  home.packages = with pkgs; [
    (pkgs.callPackage /home/morphyne/Documents/clipsy { })
    (pkgs.writeShellScriptBin "firefox" ''exec /home/morphyne/Applications/FirefoxNightly/firefox "$@"'')
    (pkgs.writeShellScriptBin "flclash" ''exec /home/morphyne/Applications/FlClash/FlClash "$@"'')
    gsettings-desktop-schemas
    sound-theme-freedesktop
    nautilus
    wofi
    libnotify
    brightnessctl
    libcanberra-gtk3
    playerctl
    grim
    slurp
    grimblast
    wl-clipboard
    obsidian
    krita
    imv
    mpv
    nixd
    zed-editor
    mpvpaper
  ];

  ##############################################################
  # MangoHud
  ##############################################################
  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      fps_limit = 0;
      frame_timing = true;
      gpu_stats = true;
      cpu_stats = true;
      vram = true;
      ram = true;
      position = "top-left";
    };
  };

  ##############################################################
  # SwayOSD и стили
  ##############################################################
  services.swayosd = {
    enable = true;
    topMargin = 0.85;  # 0.0 = у самого верха, 0.5 = центр экрана
    stylePath = "${config.xdg.configHome}/swayosd/style.css";
  };

  xdg.configFile."swayosd/style.css".text = ''
    window#osd {
      border-radius: 999px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      background-color: rgba(30, 30, 46, 0.95);
    }

    window#osd #container {
      margin: 16px;
    }

    window#osd image,
    window#osd label {
      color: #e0def4;
    }

    window#osd progressbar,
    window#osd segmentedprogress {
      min-height: 6px;
      border-radius: 999px;
      background: transparent;
      border: none;
    }

    window#osd trough,
    window#osd segment {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background-color: rgba(224, 222, 244, 0.15);
    }

    window#osd progress,
    window#osd segment.active {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background-color: #9ccfd8;
    }
  '';

  ##############################################################
  # Переменные окружения сессии
  ##############################################################
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/glib-2.0/schemas:${pkgs.gtk3}/share/glib-2.0/schemas";
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
  };

  programs.home-manager.enable = true;
  services.playerctld.enable = true;
}
