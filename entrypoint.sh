#!/bin/sh

echo "Checking aria2.conf ..."
if [ ! -f /etc/aria2.conf ]; then
cat > /etc/aria2.conf <<EOF
enable-rpc=true
rpc-listen-all=true
rpc-secret=${RPC_SECRET:-}
dir=${DOWNLOAD_DIR:-/downloads}
max-concurrent-downloads=${CONCURRENT_DOWNLOADS:-5}
piece-length=1M
min-split-size=${MIN_SPLIT_SIZE:-1M}
split=${SPLIT:-5}
max-connection-per-server=${CONNECTIONS_PER_SERVER:-16}
user-agent=${USER_AGENT:-}
file-allocation=${FILE_ALLOCATION:-none}
allow-overwrite=${ALLOW_OVERWRITE:-true}
auto-file-renaming=${AUTO_FILE_RENAMING:-false}
disk-cache=${DISK_CACHE:-64M}
check-integrity=true
max-tries=10
retry-wait=10
max-file-not-found=1
auto-file-renaming=false
disable-ipv6=true
quiet=${QUIET:-false}
on-download-complete=/on-download-complete.sh
EOF
echo "Created aria2.conf"
fi

echo "Checking rclone.conf ..."
if [ ! -f /root/.config/rclone/rclone.conf ]; then
mkdir -p /root/.config/rclone/
cat > /root/.config/rclone/rclone.conf <<EOF
[minio]
type = s3
provider = Minio
env_auth = false
access_key_id = $RCLONE_S3_ACCESS_KEY_ID
secret_access_key = $RCLONE_S3_SECRET_ACCESS_KEY
region = us-east-1
endpoint = $RCLONE_S3_ENDPOINT
EOF
echo "Created rclone.conf"
fi

echo "Checking RCLONE connection ..."
rclone mkdir minio:$RCLONE_S3_BUCKET

exec "$@"


