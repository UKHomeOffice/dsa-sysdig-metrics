#!/bin/sh
sed 's/,$//' api.log | grep '{"proxy_proto_address"' | jq -s . > metrics.json #this needs to pick up rotated log
sed 's/,$//' frontend.log | grep '{"proxy_proto_address"' | jq -s . > metrics_frontend.json
