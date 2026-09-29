{ config, lib, pkgs, ... }:

{
  ##############################################################
  # nix-ld — совместимость сторонних бинарников
  ##############################################################
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    # --- База и системные библиотеки ---
    dbus
    dconf
    e2fsprogs
    expat
    glib
    stdenv.cc.cc.lib
    udev
    zlib

    # --- Графика и OpenGL ---
    cairo
    libdrm
    libepoxy
    libgbm
    libGL
    libglvnd
    mesa

    # --- Шрифты и текст ---
    fontconfig
    freetype
    gdk-pixbuf
    harfbuzz
    pango

    # --- GTK и интерфейс (трей, доступность) ---
    at-spi2-atk
    at-spi2-core
    ayatana-ido
    gtk3
    keybinder3
    libayatana-appindicator
    libayatana-indicator
    libdbusmenu

    # --- Qt ---
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtsvg

    # --- X11 и Wayland ---
    libx11
    libxcb
    libxcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxkbcommon
    libxrandr
    libxscrnsaver
    libxshmfence
    libxtst
    wayland

    # --- Звук и видео ---
    alsa-lib
    ffmpeg
    libpulseaudio

    # --- Прочее (печать, сеть/сертификаты) ---
    cups
    nspr
    nss
  ];
}
