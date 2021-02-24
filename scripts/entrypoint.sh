#!/bin/sh
touch tracing.json
python3 expose-port.py
while true; do
    ./kubelogs.sh
    ./converttojson.sh
    python3 monitoring.py
    sleep 180
done