FROM alpine:3.8

RUN apk add --no-cache docker

CMD ["/usr/sbin/crond", "-f"]

COPY crontab /etc/crontabs/root
