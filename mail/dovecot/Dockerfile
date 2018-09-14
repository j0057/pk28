FROM alpine:3.7
RUN apk --no-cache upgrade
RUN apk --no-cache add dovecot dovecot-ldap
CMD ["/usr/sbin/dovecot", "-F", "-c", "/etc/dovecot/dovecot.conf"]
EXPOSE 110
EXPOSE 143
COPY dovecot.conf /etc/dovecot/
COPY dovecot-ldap.conf /etc/dovecot/dovecot-ldap.conf
