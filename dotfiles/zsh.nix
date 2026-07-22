{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    #Алиасы
    shellAliases = {
      nix-up = "sudo nixos-rebuild switch";
      nix-clean = "sudo nix-collect-garbage -d";
      z = "zeditor";
    };

    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    initContent = ''
      setopt AUTO_CD
      setopt EXTENDED_GLOB
      export PATH="$HOME/.local/bin:$PATH"

      if (( COLUMNS >= 103 && LINES >= 22 )); then
        fastfetch
      fi
    '';

    # Автозапуск Hyprland через UWSM сразу после автологина в tty
    # (замена SDDM — см. предыдущий шаг с getty.autologinUser)
    profileExtra = ''
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
