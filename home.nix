{ config, pkgs, ... }:

{
  home.username = "ht";
  home.homeDirectory = "/home/ht";

  home.packages = with pkgs; [ neofetch ];

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  home.file.".config/bspwm/bspwmrc" = {
    source = ./config/bspwm/bspwmrc;
    executable = true;
  };
  home.file.".config/sxhkd/sxhkdrc" = {
    source = ./config/sxhkd/sxhkdrc;
    executable = true;
  };
  home.file.".config/picom/picom.conf" = {
    source = ./config/picom/picom.conf;
  };
  home.file.".config/kitty/kitty.conf" = {
    source = ./config/kitty/kitty.conf;
  };
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
