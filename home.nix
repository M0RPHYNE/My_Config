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
  ];

  home.username = "morphyne";
  home.homeDirectory = "/home/morphyne";
  home.stateVersion = "25.11";

  ##############################################################
  # Пользовательские пакеты
  ##############################################################
  home.packages = with pkgs; [
    (pkgs.callPackage /home/morphyne/Documents/clipsy { })
    nautilus
    wofi
    libnotify
    brightnessctl
    playerctl
    grim
    slurp
    wl-clipboard
    firefox
    discord
    obsidian
    krita
    imv
    mpv
    nixd
    zed-editor

  ];

  ##############################################################
  # Polkit-агент
  ##############################################################
  services.hyprpolkitagent.enable = true;

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
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
  };

  programs.home-manager.enable = true;
}
