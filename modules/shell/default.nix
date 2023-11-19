{ config, pkgs, ... }:

{
 system.userActivationScripts.configSymlinks = [
   ''
     if [[ ! -h "$HOME/.config/kitty" ]]; then
       ln -s "$PWD/kitty" "$HOME/.config/kitty"
     fi
   ''
 
   ''
     if [[ ! -h "$HOME/.config/starship.toml" ]]; then
       ln -s "$PWD/starship.toml" "$HOME/.config/starship.toml"
     fi
   ''
   
   ''
     if [[ ! -h "$HOME/.zshrc" ]]; then
       ln -s "$PWD/.zshrc" "$HOME/.zshrc"
     fi
   ''
 ];
}

