{ pkgs, ... }:

{
  ##############################################################
  # Тема GTK / иконки / курсор — влияет на Nautilus и другие
  # GTK-приложения (nautilus, pavucontrol, wofi и т.д.)
  ##############################################################
  gtk = {
    enable = true;


    gtk3.theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraCss = ''
      @define-color accent_color #9ccfd8;
      @define-color accent_bg_color #31748f;
      @define-color accent_fg_color #191724;

      @define-color window_bg_color #191724;
      @define-color window_fg_color #e0def4;

      @define-color view_bg_color #1f1d2e;
      @define-color view_fg_color #e0def4;

      @define-color headerbar_bg_color #1f1d2e;
      @define-color headerbar_fg_color #e0def4;
      @define-color headerbar_border_color #e0def4;
      @define-color headerbar_backdrop_color #191724;
      @define-color headerbar_shade_color rgba(0, 0, 0, 0.15);

      @define-color sidebar_bg_color #17151f;
      @define-color sidebar_fg_color #908caa;
      @define-color sidebar_backdrop_color #17151f;
      @define-color sidebar_border_color rgba(49, 116, 143, 0.2);
      @define-color sidebar_shade_color rgba(0, 0, 0, 0.15);

      @define-color popover_bg_color #26233a;
      @define-color popover_fg_color #e0def4;

      @define-color card_bg_color #26233a;
      @define-color card_fg_color #e0def4;
      @define-color card_shade_color rgba(0, 0, 0, 0.2);

      @define-color dialog_bg_color #1f1d2e;
      @define-color dialog_fg_color #e0def4;

      @define-color destructive_color #eb6f92;
      @define-color destructive_bg_color #eb6f92;
      @define-color destructive_fg_color #191724;

      @define-color success_color #9ccfd8;
      @define-color success_bg_color #31748f;
      @define-color success_fg_color #191724;

      @define-color warning_color #f6c177;
      @define-color warning_bg_color #f6c177;
      @define-color warning_fg_color #191724;

      @define-color error_color #eb6f92;
      @define-color error_fg_color #191724;

      @define-color window_shade_color rgba(0, 0, 0, 0.25);
      @define-color shade_color rgba(0, 0, 0, 0.15);
      @define-color scrollbar_outline_color rgba(0, 0, 0, 0.5);


      window.background {
        background-color: rgba(25, 23, 36, 0.5);
      }


      headerbar,
      .top-bar {
        background-color: rgba(31, 29, 46, 0.58);
        box-shadow: none;
        min-height: 46px;
      }

      headerbar:backdrop,
      .top-bar:backdrop {
        background-color: rgba(25, 23, 36, 0.5);
      }


      .sidebar,
      placessidebar,
      .navigation-sidebar,
      list.navigation-sidebar {
        background-color: rgba(23, 21, 31, 0.6);
      }

      gridview,
      listview,
      scrolledwindow > viewport {
        background-color: rgba(31, 29, 46, 0.4);
      }

      statuspage,
      .empty-state {
        background-color: rgba(31, 29, 46, 0.4);
      }

      .sidebar row,
      placessidebar row,
      .navigation-sidebar row,
      gridview > child,
      listview > row {
        border-radius: 10px;
        margin: 2px 6px;
      }

      .sidebar row:selected,
      placessidebar row:selected,
      .navigation-sidebar row:selected,
      gridview > child:selected,
      listview > row:selected {
        background: linear-gradient(135deg, rgba(49, 116, 143, 0.55) 0%, rgba(196, 167, 231, 0.3) 100%);
      }

      .sidebar row:hover,
      placessidebar row:hover,
      .navigation-sidebar row:hover,
      gridview > child:hover,
      listview > row:hover {
        background-color: rgba(156, 207, 216, 0.12);
      }

      entry {
        background-color: #26233a;
        color: #e0def4;
        border: 1px solid rgba(49, 116, 143, 0.3);
        border-radius: 10px;
      }

      entry:focus-within {
        border-color: rgba(156, 207, 216, 0.7);
      }

      scrollbar slider {
        background-color: rgba(49, 116, 143, 0.4);
        border-radius: 10px;
      }

      scrollbar slider:hover {
        background-color: rgba(156, 207, 216, 0.6);
      }
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Bibata-Modern-Ice";
      cursor-size = 24;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      search-filter-time-type = "last_modified";
      show-hidden-files = false;
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "large";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = "(1100, 700)";
      maximized = false;
    };
  };

}
