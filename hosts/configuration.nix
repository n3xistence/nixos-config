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
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "qwertz";
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      
      videoDrivers = [
        "amdgpu"
      ];

      displayManager = {
    	  lightdm = {
    	    enable = true;
    	  };
    	  defaultSession = "xfce";
      };	
      desktopManager = {
    	  xfce = {
    	    enable = true;
    	  };
      };
      windowManager = {
        bspwm = {
          enable = true;
  	    };
      };
    };
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
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
      neovim
      gcc
      discord
    ];
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
  ];

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

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  users.extraUsers.${user}.extraGroups = [ "audio" ];

  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.extraConfig = "unload-module module-suspend-on-idle";

  nix = {
    extraOptions = "experimental-features = nix-command flakes";
  };

  environment = {
    variables = {
      TERMINAL  = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}

