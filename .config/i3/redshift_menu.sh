#!/bin/bash

# small power menu using rofi, i3, systemd and pm-utils
# (last 3 dependencies are adjustable below)
# tostiheld, 2016

night_command="redshift -O 1500k"
kill_command="redshift -x"
redshift_command="redshift"

# you can customise the rofi command all you want ...
rofi_command="rofi -show run -location 2  -width 75 -hide-scrollbar -l
3 -bg blue -opacity 10 -padding 5 -line-margin 15"

options=$'night\nkill\nredshift\n'

# ... because the essential options (-dmenu and -p) are added here
eval \$"$(echo "$options" | $rofi_command -dmenu -p "")_command"

