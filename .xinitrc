# load resource file and merge with the current settings
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# fonts
#xset fp+ $HOME/.fonts/misc
#xset fp+ $HOME/.fonts/ohsnap
#xset fp+ $HOME/.fonts/terminesspowerline
#xset fp+ $HOME/.fonts/tewi
#fc-cache -v

# auto enter i3 window manager
exec i3
# startup ibus daemon
ibus-daemon --xim &
