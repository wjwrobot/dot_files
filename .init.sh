# ~/.init.sh
# my private init scripy

sudo systemctl start privoxy.service		#privoxy
sudo systemctl start sshd.socket            #ssh server
sudo ssr start &> /dev/null                 #ssr
#ibus-daemon --xim &                        #ibus im
(fcitx &) &> /dev/null                        #fcitx im
sudo wifi-menu                              #wifi
compton -b
#emacs --daemon
