{ config, pkgs, ... }:

{
  home.username = "ht";
  home.homeDirectory = "/home/ht";

  home.packages = with pkgs; [ neofetch ];

  home.file.".config/bspwm/bspwmrc" = {
    source = ./config/bspwm/bspwmrc;
    executable = true;
  };
  home.file.".config/sxhkd/sxhkdrc" = {
    source = ./config/sxhkd/sxhkdrc;
    executable = true;
  };
  #home.file.".config/picom/picom.conf" = {
  #source = ./config/picom/picom.conf;
  #};
  home.file.".config/wall-paper" = {
    source = ./wall-paper;
    recursive = true;
  };
  home.file.".config/polybar/" = {
    source = ./config/polybar;
    recursive = true;
  };
  home.file.".config/rofi/" = {
    source = ./config/rofi;
    recursive = true;
  };
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
