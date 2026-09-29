{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in

{
  imports = [
    ./hardware-configuration.nix
    ./dotfiles/nix-ld.nix
    ./dotfiles/silent-sddm.nix
    <home-manager/nixos>
  ];

  ##############################################################
  # Загрузчик и ядро
  ##############################################################
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = false;
    device = "nodev";
    useOSProber = true;
    configurationLimit = 10;
  };
  boot.loader.efi = {
    efiSysMountPoint = "/boot";
    canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.abmlevel=0" ];
  boot.kernelModules = [
    "mt7921e"
    "tun"
  ];
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom=RU
    options mt7921e disable_aspm=1
  '';

  ##############################################################
  # Система
  ##############################################################
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.wirelessRegulatoryDatabase = true;
  networking.firewall.enable = false;

  system.stateVersion = "25.11";

  ##############################################################
  # Оборудование — Bluetooth, графика, звук, питание
  ##############################################################
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;

  services.power-profiles-daemon.enable = true;

  ##############################################################
  # Планировщик
  ##############################################################
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  ##############################################################
  # Память — zram, файл подкачки
  ##############################################################
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
      priority = 10;
    }
  ];

  ##############################################################
  # Сеть, время, локаль
  ##############################################################
  networking.hostName = "morphyne";
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  time.timeZone = "Asia/Krasnoyarsk";
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.supportedLocales = [
    "ru_RU.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  ##############################################################
  # Hyprland, порталы и экран блокировки
  ##############################################################
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

  security.pam.services.hyprlock = {};

  programs.dconf.enable = true;

  ##############################################################
  # Печать, файловые сервисы, шрифты, Flatpak
  ##############################################################
  services.printing.enable = true;
  services.gvfs.enable = true;
  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  ##############################################################
  # Steam / игры
  ##############################################################
  programs.steam.enable = true;

  ##############################################################
  # Пользователь и оболочка
  ##############################################################
  users.users.morphyne = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  programs.zsh.enable = true;

  ##############################################################
  # Home Manager
  ##############################################################
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.morphyne = import ./home.nix;
    extraSpecialArgs = {
      inherit unstable;
    };
  };

  ##############################################################
  # Системные пакеты
  ##############################################################
  environment.systemPackages = with pkgs; [
    # --- Базовые утилиты ---
    _7zz
    file
    git
    unzip
    wget

    # --- Диагностика и железо ---
    acpi
    btop
    lm_sensors
    pciutils
    strace
    usbutils
    util-linux

    # --- Сеть ---
    iw
    networkmanagerapplet

    # --- Звук и обои ---
    pavucontrol
    waypaper

    # --- Игры и Wine ---
    gamescope
    mangohud
    steam-run
    winetricks
    wineWow64Packages.stable
  ];

  ##############################################################
  # Сервис Happ
  ##############################################################
  systemd.services.happd = {
    description = "Happ Process Control Daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";

      # В NixOS нельзя использовать /bin/happd — указываем реальный путь
      ExecStart = "/home/morphyne/Applications/Happ/opt/happ/bin/happd";

      # Демон специально завершается с кодом 0 при подключении обновлённого клиента,
      # поэтому используем always, а не on-failure
      Restart = "always";
      RestartSec = "5s";

      # Демону требуются привилегии для запуска sing-box с TUN
      NoNewPrivileges = false;

      TimeoutStopSec = "10s";
      KillMode = "mixed";
      KillSignal = "SIGTERM";
    };
  };
}
