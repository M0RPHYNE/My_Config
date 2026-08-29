{ config, lib, pkgs, ... }:

let
  # SilentSDDM не оформлен как классический channel-модуль, поэтому тянем
  # его module.nix напрямую с main-ветки — без необходимости включать flakes.
  silentSDDMSrc = builtins.fetchTarball {
    url = "https://github.com/uiriansan/SilentSDDM/archive/refs/heads/main.tar.gz";
  };
in
{
  imports = [ "${silentSDDMSrc}/nix/module.nix" ];

  programs.silentSDDM = {
    enable = true;
    theme = "rei"; # берём самую минималистичную встроенную тему как базу

    settings = {
      # === Фон ===
      "LoginScreen" = {
        background = "/home/morphyne/Pictures/Wallpaper/TON_L.jpeg";
        blur = 4;
        brightness = -0.25;
        saturation = -0.15;
      };
      "LockScreen" = {
        background = "/home/morphyne/Pictures/Wallpaper/TON_L.jpeg";
        blur = 4;
        brightness = -0.25;
        saturation = -0.15;
      };

      # === Часы на LockScreen (сначала видим это, если он у тебя включён и там) ===
      "LockScreen.Clock" = {
        position = "center";
        font-family = "Nasalization";
        font-size = 90;
        font-weight = 600;
        color = "#e0def4"; # rosé pine text
      };
      "LockScreen.Date" = {
        font-family = "Nasalization";
        font-size = 16;
        color = "#6e6a86"; # rosé pine muted
        margin-top = 6;
      };
      "LockScreen.Message" = {
        text = "нажми что-нибудь";
        font-family = "JetBrainsMono Nerd Font";
        font-size = 12;
        color = "#6e6a86";
      };

      # === Область логина ===
      "LoginScreen.LoginArea" = {
        position = "center";
        margin = -1; # -1 = центрировать по вертикали
      };

      "LoginScreen.LoginArea.Avatar" = {
        shape = "circle";
        active-size = 88;
        inactive-size = 56;
        active-border-size = 2;
        active-border-color = "#c4a7e7"; # iris
        inactive-border-color = "#6e6a86";
        inactive-opacity = 0.4;
      };

      "LoginScreen.LoginArea.Username" = {
        font-family = "Nasalization";
        font-size = 16;
        font-weight = 600;
        color = "#e0def4";
        margin = 14;
      };

      "LoginScreen.LoginArea.PasswordInput" = {
        width = 260;
        height = 44;
        background-color = "#1f1d2e"; # surface
        background-opacity = 0.85;
        border-size = 1;
        border-color = "#26233a"; # overlay
        border-radius-left = 22;
        border-radius-right = 22;
        content-color = "#e0def4";
        font-family = "JetBrainsMono Nerd Font";
        font-size = 12;
        icon-size = 14;
        margin-top = 16;
      };

      "LoginScreen.LoginArea.LoginButton" = {
        background-color = "#c4a7e7";
        background-opacity = 0.15;
        active-background-color = "#c4a7e7";
        active-background-opacity = 0.3;
        content-color = "#e0def4";
        active-content-color = "#191724";
        border-radius-left = 22;
        border-radius-right = 22;
      };

      "LoginScreen.LoginArea.WarningMessage" = {
        normal-color = "#6e6a86";
        warning-color = "#f6c177"; # gold
        error-color = "#eb6f92";   # love
      };

      # === Нижняя менюшка: сессия / раскладка / питание ===
      "LoginScreen.MenuArea.Session" = {
        background-color = "#1f1d2e";
        background-opacity = 0.7;
        content-color = "#e0def4";
        active-content-color = "#c4a7e7";
        font-size = 11;
      };
      "LoginScreen.MenuArea.Layout" = {
        background-color = "#1f1d2e";
        background-opacity = 0.7;
        content-color = "#e0def4";
        active-content-color = "#9ccfd8"; # foam
      };
      "LoginScreen.MenuArea.Power" = {
        background-color = "#1f1d2e";
        background-opacity = 0.7;
        content-color = "#e0def4";
        active-content-color = "#eb6f92"; # love
      };

      "Tooltips" = {
        font-family = "JetBrainsMono Nerd Font";
        content-color = "#e0def4";
        background-color = "#191724";
        background-opacity = 0.9;
      };
    };
  };
}
