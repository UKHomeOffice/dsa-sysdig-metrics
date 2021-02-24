#!/bin/sh
set -e
crond
echo "* * * * * echo hello > /APP/hello.txt" | crontab - && crond -f -L /dev/stdout
