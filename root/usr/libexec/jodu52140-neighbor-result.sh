#!/bin/sh
# /usr/libexec/jodu52140-neighbor-result.sh - Returns status/result of the background scan
LOCK="/tmp/odu_neighbor.lock"
OUT="/tmp/odu_neighbor_result.txt"

if [ -f "$LOCK" ]; then
    echo "PENDING"
    exit 0
fi

if [ -f "$OUT" ]; then
    cat "$OUT"
    rm -f "$OUT"
    exit 0
fi

echo "NONE"
