# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

let 
  user = "nex";
in
{
  imports =
    [(import ./hardware-configuration.nix )];
#      // import Hyprland config here    

  networking = {
    hostName = "nixos"; # Define your hostname.
    
    wireless = {
      enable = true;

      networks = {
        MiNi = {
          psk = "0307250910112211";
        }; 
      };
    };
  };

  services = {
    xserver = {
      libinput.enable = true;
      
      videoDrivers = [
        "amdgpu"
      ];
    };
  };

  hardware.bluetooth = {
    enable = true;
    hsphfpd.enable = true;
    settings = {
        General = {
	      Enable = "Source,Sink,Media,Socket";
      };
    };
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

  users.extraUsers.${user}.extraGroups = [ "audio" ];
}

