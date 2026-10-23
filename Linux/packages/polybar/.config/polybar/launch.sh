#!/usr/bin/env bash
config_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd) || exit 1
pkill -u "$UID" -x polybar 2>/dev/null || true
for ((i=0; i<50; i++)); do
    pgrep -u "$UID" -x polybar >/dev/null || break
    sleep 0.1
done
if pgrep -u "$UID" -x polybar >/dev/null; then
    printf 'Polybar anterior não encerrou.\n' >&2; exit 1
fi
polybar main -c "$config_dir/config.ini" &
if [[ -n ${POLYBAR_EXTERNAL_MONITOR:-} ]]; then
    polybar external -c "$config_dir/config.ini" &
fi
