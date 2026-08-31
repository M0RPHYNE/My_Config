{ config, pkgs, unstable, ... }:

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
    ./dotfiles/hyprtoolkit.nix
    #.dotfiles/hyprqt6engine.nix
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
    termius
    unstable.orca-slicer
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
