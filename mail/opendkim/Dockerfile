FROM alpine:3.9
RUN apk --no-cache add socat
RUN apk --no-cache add opendkim opendkim-utils bash

RUN install -o opendkim -g opendkim -m 700 -d /run/opendkim

EXPOSE 8891
CMD socat -u unix-recv:/dev/log stdout | cut -c 5- & \
    exec opendkim -f

COPY opendkim.conf /etc/opendkim/
COPY opendkim-rekey /usr/local/bin/
