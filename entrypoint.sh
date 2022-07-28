#!/bin/sh

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
quiet=${QUIET:-false}
EOF

fi

if [[ -n "$PUID" && -n "$PGID" ]]; then
    data_path=/downloads
    userid=$PUID
    groupid=$PGID
    chown -R "$userid":"$groupid" $data_path
    echo "Running as user $PUID:$PGID"    
fi

exec "$@"


