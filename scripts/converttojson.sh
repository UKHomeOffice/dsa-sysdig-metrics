#!/bin/sh
sed 's/,$//' api.log | jq -s . > metrics.json #this needs to pick up rotated log
