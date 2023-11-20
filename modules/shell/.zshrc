bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;6D" backward-word
bindkey "^[[1;6C" forward-word

alias cls='clear'
alias vim='nvim'
alias la='ls -la'
alias clip='xclip -se c'
alias paste='xclip -se c -o'
alias ..='cd ..'
alias ...='cd ../..'
alias sudoe='sudo -E -s'
alias hy='Hyprland'

function zle-line-init {
   marking=0
}
zle -N zle-line-init

function select-char-right {
   if (( $marking != 1 )) 
   then
       marking=1
       zle set-mark-command
   fi
   zle .forward-char
}
zle -N select-char-right

function select-char-left {
   if (( $marking != 1 )) 
   then
       marking=1
       zle set-mark-command
   fi
   zle .backward-char
}
zle -N select-char-left

function forward-char {
   if (( $marking == 1 ))
   then
       marking=0
       NUMERIC=-1 zle set-mark-command
   fi
   zle .forward-char
}
zle -N forward-char

function backward-char {
   if (( $marking == 1 ))
   then
       marking=0
       NUMERIC=-1 zle set-mark-command
   fi
   zle .backward-char
}
zle -N backward-char

function delete-char {
   if (( $marking == 1 ))
   then
       zle kill-region
       marking=0
   else
       zle .delete-char
   fi
}
zle -N delete-char

function select-word-right {
  if (( $marking != 1 )) 
  then
      marking=1
      zle set-mark-command
  fi
  zle .forward-word
}
zle -N select-word-right

function select-word-left {
  if (( $marking != 1 )) 
  then
      marking=1
      zle set-mark-command
  fi
  zle .backward-word
}
zle -N select-word-left

bindkey '^[[1;2D' select-char-left  # assuming xterm
bindkey '^[[1;2C' select-char-right # assuming xterm

bindkey '^[[1;4D' select-word-left  # assuming xterm
bindkey '^[[1;4C' select-word-right # assuming xterm


eval "$(starship init zsh)"
