#!/bin/sh
sed 's/,$//' api.log | awk -v s='{"proxy_proto_address' 'index($0, s) == 1' | grep '\" }$' | jq -s . > metrics.json #this needs to pick up rotated log
sed 's/,$//' frontend.log | awk -v s='{"proxy_proto_address' 'index($0, s) == 1' | grep '\" }$' | jq -s . > metrics_frontend.json
