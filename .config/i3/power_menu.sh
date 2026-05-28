#!/bin/bash

# small power menu using rofi, i3, systemd and pm-utils
# (last 3 dependencies are adjustable below)
# tostiheld, 2016

poweroff_command="systemctl poweroff"
reboot_command="systemctl reboot"
logout_command="i3-msg exit"
hibernate_command="systemctl hibernate"
suspend_command="systemctl suspend"

# you can customise the rofi command all you want ...
rofi_command="rofi -show run -location 6 -hide-scrollbar -l 5 -bg #586e75 -opacity 100 -padding 2"

options=$'poweroff\nreboot\nlogout\nhibernate\nsuspend\n'

# ... because the essential options (-dmenu and -p) are added here
eval \$"$(echo "$options" | $rofi_command -dmenu -p "")_command"

