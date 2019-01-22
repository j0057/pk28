FROM joostm/alpine_openrc:3.8

COPY rsyslog_config.sh /etc/init.d/rsyslog_config

RUN apk add --no-cache rsyslog \
    && echo 'rc_need="rsyslog_config"' >> /etc/conf.d/rsyslog \
    && echo 'rc_after="rsyslog_config"' >> /etc/conf.d/rsyslog \
    && rc-update add rsyslog_config default \
    && rc-update add rsyslog default
