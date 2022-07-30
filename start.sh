#!/bin/sh

rclone rcd --rc-addr ":5572" --rc-files "/downloads" --rc-web-gui-no-open-browser --rc-no-auth &
aria2c --conf-path=/etc/aria2.conf;rclone rcd --rc-addr ":5572" --rc-files "/downloads" --rc-web-gui-no-open-browser --rc-no-auth