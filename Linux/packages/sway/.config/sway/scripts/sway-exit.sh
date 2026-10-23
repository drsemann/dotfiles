#!/usr/bin/env bash
set -u
chosen=$(printf '%s\n' lock logout suspend restart shutdown | rofi -dmenu -p 'Sessão:' -config "$HOME/.config/sway/rofi/config.rasi") || exit 0
case "$chosen" in
    lock) gtklock ;;
    logout) swaymsg exit ;;
    suspend) systemctl suspend ;;
    restart) systemctl reboot ;;
    shutdown) systemctl poweroff ;;
    *) exit 0 ;;
esac
