{ ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/morphyne/Pictures/home.jpeg"
      ];

      wallpaper = [
        {
          monitor = "";
          path = "/home/morphyne/Pictures/home.jpeg";
        }
      ];
    };
  };
}
