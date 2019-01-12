FROM joostm/alpine_openrc:3.8

RUN apk add --no-cache rsyslog \
    && rc-update add rsyslog default

COPY rsyslog.conf /etc/rsyslog.conf
