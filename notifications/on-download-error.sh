#!/bin/sh
file_path=$3
file_name=${file_path##*/}
gid=$1
uuid=$(cat /proc/sys/kernel/random/uuid)
now=$(date -Iseconds)

if [ "$PUBLISH_EVENTS" = true ];then
    curl -i -X POST http://localhost:3500/v1.0/publish/pubsub/FileDownloadError \
    -H "Content-Type: application/cloudevents+json" \
    -d '{"specversion" : "1.0", "type" : "AshLake.Contracts.Collector:FileDownloadError", "source" : "AshLake.Service.Collector", "id" : "'$uuid'", "time" : "'$now'", "datacontenttype" : "application/cloudevents+json", "data" : {"gid" : "'$gid'" , "fileName" : "'$file_name'"}}' 
fi