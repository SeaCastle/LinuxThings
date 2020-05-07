# .bash_profile

#Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Not sure if this is needed or what it is
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Autostart x-session on login
# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && XDG_VTNR -eq 1 ]]; then
   startx #change to "exec startx" if you want to be logged out when the x-session ends 
fi

