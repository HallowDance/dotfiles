#!/bin/bash

#load bookmarks file
file="$HOME/.config/i3/bookmarks"
#temp file
boomarks_tmp="$HOME/.config/i3/bookmarks_tmp"
while read line; do
        options+=$line$'\n'   
done < $file


rofi_command='rofi -show run -location 2 -width 800
-hide-scrollbar -l 10 -bg #586e75 -opacity 100 -padding 2'
# ... because the essential options (-dmenu and -p) are added here    
choice="$(echo "$options" | $rofi_command -font "Inconsolata 12" -dmenu -p "")"  
if ! [ -z "$choice" ] 
then
  eval brave $(echo "$choice" | cut -d'|' -f2-)
fi
# put chosen command at the top
sed -i "1 i$choice" $file
# remove duplicates
awk '!visited[$0]++' $file > $boomarks_tmp
mv $boomarks_tmp $file
