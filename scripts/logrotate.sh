#!/bin/bash
DATE=`date +%Y%m%d`
BASE_DIR='/APP/scripts'
if [ -f $BASE_DIR/api.log ]; then
    cp $BASE_DIR/api.log $BASE_DIR/api.log.$DATE
    > $BASE_DIR/api.log
fi

find $BASE_DIR -name 'api.log.*' -a -mtime +7 -exec rm {} \;
