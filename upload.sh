#!/bin/sh
file_path=$3
file_name=${file_path##*/}
rclone move -v $file_path minio:$RCLONE_S3_BUCKET

if [ $NOTIFICATION_ENDPOINT ];then
    curl -i -X POST $NOTIFICATION_ENDPOINT\
    -H "Content-Type: application/json" \
    -d '{"type":"object.upload.completed","source":"rclone","data":{"object":"'$file_name'"}}' 
fi