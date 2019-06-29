[[ -f ~/.bashrc ]] && . ~/.bashrc

# my configure
# ----------------------------------
# auto start X at login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
#	exec nvidia-xrun
fi

#export PATH="$HOME/.cargo/bin:$PATH"
export GTK_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
# -------------------------------------
