FROM joostm/alpine_openrc:3.8

RUN apk add --no-cache rsyslog \
    && echo -en 'module(load="imuxsock")\n*.* @syslog:514\n' >/etc/rsyslog.conf \
    && rc-update add rsyslog default

RUN apk add --no-cache docker

COPY init.sh /etc/init.d/crond
COPY crontab /etc/crontabs/root

RUN rc-update add crond default
