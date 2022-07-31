#!/bin/sh
file_path=$3
file_name=${file_path##*/}
gid=$1
uuid=$(cat /proc/sys/kernel/random/uuid)
now=$(date -Iseconds)

if [ "$AUTO_UPLOAD" = true ];then
    rclone move -v $file_path minio:$RCLONE_S3_BUCKET
fi

if [ "$PUBLISH_EVENTS" = true ];then
    curl -i -X POST http://localhost:3500/v1.0/publish/pubsub/FileDownloadCompleted \
    -H "Content-Type: application/cloudevents+json" \
    -d '{"specversion" : "1.0", "type" : "AshLake.Contracts.Collector:FileDownloadCompleted", "source" : "AshLake.Service.Collector", "id" : "'$uuid'", "time" : "'$now'", "datacontenttype" : "application/cloudevents+json", "data" : {"gid" : "'$gid'" , "fileName" : "'$file_name'"}}' 
fi