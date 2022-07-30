FROM alpine:3.15
VOLUME /downloads
EXPOSE 6800

RUN apk add --update --no-cache aria2 && rm -rf /var/cache/apk/*
RUN apk add --update --no-cache rclone && rm -rf /var/cache/apk/*
RUN apk add --update --no-cache curl && rm -rf /var/cache/apk/*

ADD entrypoint.sh upload.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "sh","/entrypoint.sh" ]
CMD aria2c --conf-path=/etc/aria2.conf
