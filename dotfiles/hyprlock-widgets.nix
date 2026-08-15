{ pkgs, lib, ... }:

let
  hyprlockWidgets = pkgs.rustPlatform.buildRustPackage {
    pname = "hyprlock-widgets";
    version = "0.1.0";

    # Путь к папке с проектом — положи её рядом с остальными dotfiles,
    # например ~/nixos-config/dotfiles/hyprlock-widgets/
    src = /home/morphyne/Documents/hyprlock-widgets;

    cargoLock.lockFile = /home/morphyne/Documents/hyprlock-widgets/Cargo.lock;

    # tiny-skia сам по себе чистый Rust без системных C-зависимостей,
    # так что дополнительные buildInputs не нужны
  };
in
{
  home.packages = [ hyprlockWidgets ];

  # Создаём кэш-директорию и сразу рисуем первый PNG при активации конфига,
  # иначе на самой первой загрузке hyprlock увидит несуществующий path
  # (reload_cmd срабатывает только по таймеру reload_time, не мгновенно)
  home.activation.hyprlockWidgetsInit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/.cache/hyprlock"
    $DRY_RUN_CMD ${hyprlockWidgets}/bin/hyprlock-widgets mars-temp "$HOME/.cache/hyprlock/mars-temp.png" $VERBOSE_ARG || true
  '';
}
