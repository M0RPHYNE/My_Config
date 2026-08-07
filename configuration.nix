{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];
  ##############################################################
  # Загрузчик и ядро
  ##############################################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 1;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.abmlevel=0" ];
  boot.kernelModules = [
    "mt7921e"
    "tun"
  ];

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  networking.firewall.enable = false;

  ##############################################################
  # Сессия — автологин в tty + запуск через UWSM
  ##############################################################
  services.getty.autologinUser = "morphyne";

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];

    config = {
      hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
      };
    };
  };

  security.pam.services.hyprlock = {};   # без этого hyprlock не сможет проверять пароль

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

  ##############################################################
  # Оборудование — Bluetooth, графика, звук
  ##############################################################
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;   # сам добавляет pkgs.blueman + D-Bus регистрацию

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
  security.rtkit.enable = true;   # реалтайм-планирование для pipewire, без него звук может подрагивать

  services.power-profiles-daemon.enable = true;

  ##############################################################
  # Память — zram в приоритете, файл подкачки как подстраховка
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
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Krasnoyarsk";
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.supportedLocales = [ "ru_RU.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];

  ##############################################################
  # Печать, файловые сервисы, шрифты
  ##############################################################
  services.printing.enable = true;
  services.gvfs.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  ##############################################################
  # Flatpak
  ##############################################################
  services.flatpak.enable = true;

  ##############################################################
  # Home Manager
  ##############################################################
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.morphyne = import ./home.nix;

  ##############################################################
  # Пользователь
  ##############################################################
  users.users.morphyne = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  programs.zsh.enable = true;

  ##############################################################
  # Системные пакеты
  ##############################################################

  environment.systemPackages = with pkgs; [
    wget
    git
    util-linux
    pciutils
    usbutils
    networkmanagerapplet
    acpi
    qbittorrent
    lutris
    steam-run
    file
    strace
    unzip
    mangohud
    btop
    mission-center
    lm_sensors
    pavucontrol
    polkit_gnome
    waypaper
    gamescope
  ];


  services.scx.enable = true; # Включает системную службу для eBPF планировщиков
  services.scx.scheduler = "scx_lavd"; # Указывает нужный планировщик (по умолчанию используется scx_rustland)

  ##############################################################
  # dconf — нужен для тем GTK/иконок/курсора и настроек Nautilus
  ##############################################################
  programs.dconf.enable = true;

  ##############################################################
  # Steam / игры / совместимость бинарников
  ##############################################################
  programs.steam.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    nss
    nspr
    dbus
    at-spi2-atk
    at-spi2-core
    cups
    expat
    fontconfig
    freetype
    glib
    gtk3
    pango
    cairo
    alsa-lib
    libdrm
    mesa
    libGL
    libxkbcommon
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxcb
    libxi
    libxtst
    libxcursor
    libxscrnsaver
    libxshmfence
    udev
    libgbm
    libepoxy
    libayatana-appindicator
    keybinder3
    harfbuzz
    gdk-pixbuf
    libayatana-indicator
    ayatana-ido
    libdbusmenu
    ffmpeg
    libpulseaudio
    wayland
    dconf
    libglvnd
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
