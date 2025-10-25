#!/bin/bash

res=$(rofi -dmenu -p "menu:" -config /home/netuno/.config/sway/rofi/config.rasi < /home/netuno/.config/dmenu)

if [ $res = "lock" ]; then
    gtklock
fi
if [ $res = "logout" ]; then
    swaymsg exit
fi
if [ $res = "suspend" ]; then
    systemctl suspend
fi
if [ $res = "restart" ]; then
    systemctl reboot
fi
if [ $res = "shutdown" ]; then
    systemctl poweroff
fi
exit 0
