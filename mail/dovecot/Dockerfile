FROM alpine:3.8

RUN apk --no-cache add dovecot dovecot-ldap

EXPOSE 110 143 9001 24

CMD ["/usr/sbin/dovecot", "-F", "-c", "/etc/dovecot/dovecot.conf"]

COPY dovecot.conf /etc/dovecot/
COPY dovecot-ldap.conf /etc/dovecot/dovecot-ldap.conf
