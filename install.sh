#!/bin/bash

# Install Arch Linux and configure for daily use and work
#-------------------------------------------------------------------------------
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-------------------------------------------------------------------------------
install () {
pacman -Syu
}

post-install () {
pacman -S --noconfirm vi vim wqy-microhei ttf-dejavu firefox
useradd -m -G wheel -s /bin/bash wjw
echo -e "FONT=sun12x22\nFONT_MAP=8859-2" > /etc/vconsole.conf
pacman -S --noconfirm xorg-server xorg-xinit xorg-xinput
pacman -S --noconfirm i3-gaps i3blocks i3locks rofi feh light scrot acpi termite bc pulsemixer

echo -e "defaults.pcm.card 1\ndefaults.pcm.device 0\ndefaults.ctl.card 1" > /etc/asound.conf

pacman -S --noconfirm ranger highlight xclip
}
