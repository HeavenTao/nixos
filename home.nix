{ config, pkgs, ... }:

{
  home.username = "ht";
  home.homeDirectory = "/home/ht";

  programs.git = {
    enable = true;
    userName = "Heaven";
    userEmail = "542248377@qq.com";
  };

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

   home.file.".config/bspwm/bspwmrc"={
           source= ./config/bspwm/bspwmrc;
           executable=true;
   };
   home.file.".config/sxhkd/sxhkdrc"={
           source= ./config/sxhkd/sxhkdrc;
           executable=true;
   };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
