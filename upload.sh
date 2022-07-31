#!/bin/sh
file_path=$3
file_name=${file_path##*/}
uuid=$(cat /proc/sys/kernel/random/uuid)
now=$(date -Iseconds)

if [ "$AUTO_UPLOAD" = true ];then
    rclone move -v $file_path minio:$RCLONE_S3_BUCKET
    curl -i -X POST http://localhost:3500/v1.0/publish/pubsub/S3ObjectUploaded\
    -H "Content-Type: application/cloudevents+json" \
    -d '{"specversion" : "1.0", "type" : "AshLake.Contracts.Collector:S3ObjectUploaded", "source" : "AshLake.Service.Collector", "id" : "'$uuid'", "time" : "'$now'", "datacontenttype" : "application/cloudevents+json", "data":{"objectKey":"'$file_name'"}}' 
fi