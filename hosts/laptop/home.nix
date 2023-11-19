{ config, pkgs, ... }:

{
#   imports = 
#     [(import ../../modules/shell)] ++
#     (import ../../modules/editors);

  home = {
    username = "nex";
    homeDirectory = "/home/nex";
    stateVersion = "23.05";
    packages = with pkgs; [
      htop
      unzip
      xclip
    ];
  };

  home.file = {
    # ".zshrc" = {
    #   source = "./.zshrc";
    # };
    # ".config/kitty" = {
    #   source = "./kitty";
    #   recursive = true;
    # };
    # ".config/starship.toml" = {
    #   source = "./starship.toml";
    # };
    # ".config/nvim" = {
    #   source = "./nvim";
    #   recursive = true;
    # };
  };

  programs.home-manager.enable = true;
}
