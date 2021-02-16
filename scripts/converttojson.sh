#!/bin/sh
sed 's/,$//' logs.log | jq -s . #this needs to pick up rotated log
