# ~/.init.sh
# my private init scripy

#sudo systemctl start sshd.socket            #ssh server
#sudo systemctl start NetworkManager.service #network

#ibus-daemon --xim &                        #ibus im
(fcitx &) &> /dev/null                        #fcitx im
picom -b &> /dev/null
#sudo ssr start &> /dev/null                 #ssr
trojan &> /dev/null &
sudo systemctl start privoxy.service		#privoxy

sudo wifi-menu                              #wifi
