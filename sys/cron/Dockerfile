FROM alpine:3.8

RUN apk add --no-cache docker

CMD ["crond", "-f"]

COPY crontab /etc/crontabs/root
