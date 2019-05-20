#!/bin/sh
# Profile file. Runs on login.

# auto start X at login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
#	exec nvidia-xrun
fi
