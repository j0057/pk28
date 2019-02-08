FROM alpine:3.9

RUN apk --no-cache add socat
RUN apk --no-cache add dovecot dovecot-ldap

EXPOSE 110 143 9001 24

CMD socat -u unix-recv:/dev/log stdout | cut -c 5- & \
    exec dovecot -F -c /etc/dovecot/dovecot.conf

COPY dovecot.conf /etc/dovecot/
COPY dovecot-ldap.conf /etc/dovecot/dovecot-ldap.conf
