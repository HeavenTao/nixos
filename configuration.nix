# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "ht" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  users.extraUsers.ht.extraGroups = [ "audio" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  #networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
  #networking.extraHosts = ''
  #140.82.112.3 github.com
  #140.82.113.35 ssh.github.com
  #'';
  # Easiest to use and most distros use this by default.

  #programs
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "ht" ];

  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.starship.interactiveOnly = true;

  programs.neovim.enable = true;
  programs.neovim.withNodeJs = true;
  programs.neovim.defaultEditor = true;

  programs.clash-verge.enable = true;
  programs.clash-verge.tunMode = true;
  programs.clash-verge.autoStart = true;

  programs.htop.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ht = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [ ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    google-fonts
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #services.xserver.windowManager.bspwm.enable = true;
  #services.xserver.displayManager = {
  #setupCommands = ''
  #${pkgs.xorg.xset}/bin/xset r rate 200
  #${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-2 --primary --left-of DVI-D-1
  #'';
  #defaultSession = "none+bspwm";
  #lightdm = {
  #enable = true;
  #greeter.enable = true;
  #background = ./wall-paper/wp12329545.png;
  #};
  #};
  services.xserver.displayManager = {
    sddm.enable = true;
    defaultSession = "none+awesome";
  };
  services.xserver.windowManager = { awesome = { enable = true; }; };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #tools
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    fzf
    exa
    tldr
    bat
    tree
    ranger
    tmux
    #shell
    fish
    bash
    #terminal
    kitty
    xterm
    #desktop
    sxhkd
    polybar
    arandr
    nitrogen
    rofi
    google-chrome
    papirus-icon-theme
    glances
    #program
    zig_0_9
    lua
    love
    lua52Packages.luarocks

    #language-server
    #lua
    lua-language-server

    #html/css/json/eslint
    nodePackages.vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"

    #bash
    nodePackages.bash-language-server
    beautysh

    #python
    nodePackages.pyright
    black

    #nix
    rnix-lsp
    statix
    nixfmt

    #javascript
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  networking.proxy.default = "http://127.0.0.1:7890";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-configtool
      fcitx5-chinese-addons
      fcitx5-rime
    ];
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  environment.sessionVariables = rec {
    http_proxy = "http://127.0.0.1:7890";
    https_proxy = "http://127.0.0.1:7890";
    HTTP_PROXY = "http://127.0.0.1:7890";
    HTTPS_PROXY = "http://127.0.0.1:7890";
  };
  #environment.variables = rec {
  #http_proxy = "http://127.0.0.1:7890";
  #https_proxy = "http://127.0.0.1:7890";
  #HTTP_PROXY = "http://127.0.0.1:7890";
  #HTTPS_PROXY = "http://127.0.0.1:7890";
  #};

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
