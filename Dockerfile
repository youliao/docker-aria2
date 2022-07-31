FROM alpine:3.15
VOLUME /downloads
EXPOSE 5572 6800

RUN apk add --update --no-cache aria2 && rm -rf /var/cache/apk/*
RUN apk add --update --no-cache rclone && rm -rf /var/cache/apk/*
RUN apk add --update --no-cache curl && rm -rf /var/cache/apk/*

COPY ["entrypoint.sh","start.sh","notifications","/"]

ENTRYPOINT [ "sh","/entrypoint.sh" ]
CMD [ "/start.sh" ]