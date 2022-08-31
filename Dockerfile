FROM alpine:3.15
VOLUME /downloads
EXPOSE 5572 6800

RUN sed -i 's/https/http/' /etc/apk/repositories
RUN apk add --update --no-cache aria2 && apk add --update --no-cache rclone && apk add --update --no-cache curl && rm -rf /var/cache/apk/*

COPY ["entrypoint.sh","start.sh","notifications","/"]

ENTRYPOINT [ "sh","/entrypoint.sh" ]
CMD [ "/start.sh" ]