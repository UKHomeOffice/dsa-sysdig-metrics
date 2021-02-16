
DATE=`date +%Y%m%d` 
BASE_DIR='/var/log' 
if [ -f $BASE_DIR/logname.log ]; then 
    cp $BASE_DIR/logname.log $BASE_DIR/logname.log.$DATE 
    > $BASE_DIR/logname.log 
fi 

find $BASE_DIR -name 'logname.log.*' -a -mtime +3 -exec rm {} \; 
