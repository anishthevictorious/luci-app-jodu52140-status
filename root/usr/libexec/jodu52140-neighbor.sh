#!/bin/sh
# /usr/libexec/jodu52140-neighbor.sh - Starts a background nearby-cell scan
LOCK="/tmp/odu_neighbor.lock"
OUT="/tmp/odu_neighbor_result.txt"

if [ -f "$LOCK" ]; then
    echo "BUSY"
    exit 0
fi

touch "$LOCK"
rm -f "$OUT"

(
    IP=$(/sbin/uci -q get jodu52140.main.ip || echo "192.168.225.1")
    USER=$(/sbin/uci -q get jodu52140.main.user || echo "root")
    PASS=$(/sbin/uci -q get jodu52140.main.pass || echo "oelinux123")
    AT_CMD='AT+QSCAN=2,1'

    OUTPUT=$( (
        sleep 2
        echo "$USER"
        sleep 2
        echo "$PASS"
        sleep 2
        echo "lux_atc '$AT_CMD'"
        sleep 55
        echo "exit"
        sleep 1
    ) | nc "$IP" 23 2>/dev/null )

    echo "$OUTPUT" | grep '+QSCAN:' > "$OUT"
    rm -f "$LOCK"
) >/dev/null 2>&1 &

echo "STARTED"
