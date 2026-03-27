#!/bin/bash
# Allocate 4 available ports starting from 9090

set -euo pipefail

# Find 4 available ports starting from 9090
ports=()
current_port=9090
while [ ${#ports[@]} -lt 4 ]; do
    if ! lsof -ti:$current_port > /dev/null 2>&1; then
        ports+=($current_port)
    fi
    ((current_port++))
done

# Output ports space-separated
echo "${ports[@]}"
