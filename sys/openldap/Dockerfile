FROM alpine:3.9

RUN apk --no-cache add socat
RUN apk --no-cache add openldap openldap-clients openldap-back-mdb

RUN install -o ldap -g ldap -m 700 -d /run/openldap

RUN mv /var/lib/openldap/openldap-data/DB_CONFIG.example /var/lib/openldap/openldap-data/DB_CONFIG

COPY slapd.conf /etc/openldap/slapd.conf
COPY ldap.conf /etc/openldap/ldap.conf

EXPOSE 389
STOPSIGNAL SIGTERM
CMD socat -u unix-recv:/dev/log stdout | cut -d '>' -f 2- & \
    exec slapd -f /etc/openldap/slapd.conf -u ldap -g ldap &> /dev/null

COPY data.ldif /tmp/data.ldif

RUN slapd -f /etc/openldap/slapd.conf -u ldap -g ldap \
    && ldapadd -x -D 'cn=root,dc=pk28,dc=nl' -w root -f /tmp/data.ldif \
    && rm /tmp/data.ldif \
    && pkill -TERM slapd
