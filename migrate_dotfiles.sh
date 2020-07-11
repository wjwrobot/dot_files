#!/bin/bash

# https://github.com/wjwrobot
# --------------------------------------------------
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# --------------------------------------------------

# migrate dot files and create symbol link for them.


dot_path=~/.dotfiles
# get all the files that we want to use 
# ignore visiable files, .emacs file;
# and .git, .fonts, and polybar directory.
origin=$(find $dot_path -type f ! -path "$dot_path/.git/*" ! -path "$dot_path/[a-zA-Z]*" ! -path "$dot_path/.fonts/*" ! -path "$dot_path/.emacs" ! -path "$dot_path/.config/polybar/*")

for origin_file in $origin
do
	link_file=$(echo $origin_file | sed 's|/.dotfiles/|/|g')
	install -D /dev/null $link_file #create all necessary directorys
	rm $link_file
	ln -s $origin_file $link_file
done
