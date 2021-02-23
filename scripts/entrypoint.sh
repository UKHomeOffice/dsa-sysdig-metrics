#!/bin/sh
set -e

echo "* * * * * echo hello > /APP/hello.txt" | crontab - && crond -f -L /dev/stdout
