FROM alpine:3.8

RUN apk --no-cache add opendkim opendkim-utils bash

RUN install -o opendkim -g opendkim -m 700 -d /run/opendkim

CMD ["opendkim", "-f"]

COPY opendkim.conf /etc/opendkim/
COPY opendkim-rekey /usr/local/bin/
