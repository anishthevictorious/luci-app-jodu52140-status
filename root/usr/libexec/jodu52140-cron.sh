#!/bin/sh
# /usr/libexec/jodu52140-cron.sh - Enables/disables scheduled ODU reboot via router cron
# Usage: jodu52140-cron.sh <enable 0|1> <minute> <hour>

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
    echo "$MIN $HOUR * * * /usr/libexec/jodu52140-reboot.sh $TAG" >> "$CRONFILE"
fi

/etc/init.d/cron restart >/dev/null 2>&1
