#!/bin/sh
# /usr/libexec/jodu_cron.sh - Enables/disables scheduled ODU reboot via router cron
# Usage: jodu_cron.sh <enable 0|1> <minute> <hour>

ENABLE="$1"
MIN="$2"
HOUR="$3"
CRONFILE="/etc/crontabs/root"
TAG="# jodu52140-scheduled-reboot"

touch "$CRONFILE"
grep -vF "$TAG" "$CRONFILE" > "$CRONFILE.tmp" 2>/dev/null
mv "$CRONFILE.tmp" "$CRONFILE"

if [ "$ENABLE" = "1" ]; then
    [ -z "$MIN" ] && MIN="0"
    [ -z "$HOUR" ] && HOUR="4"
    echo "$MIN $HOUR * * * /usr/libexec/jodu_reboot.sh $TAG" >> "$CRONFILE"
fi

/etc/init.d/cron restart >/dev/null 2>&1
