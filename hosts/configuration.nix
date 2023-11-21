# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

let 
  user = "nex";
in
{
#      // import Hyprland config here    

  boot = {
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      # systemd-boot = {
      #   enable = true;
      # };
      
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
      
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  services = {
    xserver = {
      # desktopManager.session.script = ''
      #   ${pkgs.wlogout}/bin/logout
      # '';
      
      layout = "de";
      xkbVariant = "qwerty";      
    };
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  users.users.${user} = {
    isNormalUser = true;
    initialPassword = "toor";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
      neofetch
      git
      zsh
      kitty
      starship
      
      nodejs_20
      typescript
      bun
      gcc

      neovim
      discord
      ranger
      obsidian
    ];
  };

  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vim 
    wget
    waybar
    dunst
    libnotify
    swww
    wlogout
    wofi

    mesa
    networkmanager
    pavucontrol
    xcape
  ];
  
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
   };
  };

  system.stateVersion = "23.05"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (self: super: {
        discord = super.discord.overrideAttrs (
          _: { src = builtins.fetchTarball {
              url = "https://discord.com/api/download?platform=linux&format=tar.gz";
              sha256 = "1xjk77g9lj5b78c1w3fj42by9b483pkbfb41yzxrg4p36mnd2hkn";
            }; }
        );
      })
  ];

  hardware = {
    opengl.enable = true;

    pulseaudio = {
      enable = true;
      support32Bit = true;
      extraConfig = "unload-module module-suspend-on-idle";
    };
  };

  users.extraUsers.${user}.extraGroups = [ "audio" ];

  nixpkgs.config.pulseaudio = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  environment = {
    variables = {
      TERMINAL  = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}

