FROM alpine:3.9

RUN apk --no-cache add socat
RUN apk --no-cache add docker

COPY crontab /etc/crontabs/root

CMD socat -u unix-recv:/dev/log stdout | cut -c 5- & \
    exec crond -f
