# load resource file and merge with the current settings
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# auto enter i3 window manager
exec i3
# startup ibus daemon
#ibus-daemon --xim &
