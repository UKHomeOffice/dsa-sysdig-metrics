#!/bin/sh
list=("api")

function lasttime(){
    lasttimefile="lastruntime.txt"
    if [ -e $lasttimefile ]; then
        lasttime=$(cat lastruntime.txt)
    else
        touch lastruntime.txt
        echo $(date -u +"%Y-%m-%dT%H:%M:%SZ") > lastruntime.txt
        lasttime=$(cat lastruntime.txt)
    fi
    
}

function collectlogs(){
    arguments=("$@") 
    for argument in "${arguments[@]}"; do
        for i in $(kubectl get pods | grep $argument | awk '{print $1}'); do
            kubectl logs $i --since-time=$lasttime >> $argument.log
            now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
            echo $now > lastruntime.txt
        done
    done
}

lasttime
collectlogs "${list[@]}"

