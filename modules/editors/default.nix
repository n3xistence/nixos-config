{ config, pkgs, ... }:

{
 system.userActivationScripts.nvimSymlink = ''
   if [[ ! -h "$HOME/.config/nvim" ]]; then
     ln -s "$PWD/nvim" "$HOME/.config/nvim"
   fi
 '';
}

