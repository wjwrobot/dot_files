# load resource file and merge with the current settings
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# modify keymaps
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# auto enter i3 window manager
exec i3
#exec dwm
# startup ibus daemon
#ibus-daemon --xim &
