FROM alpine:3.8

RUN apk --no-cache upgrade \
    && apk --no-cache add postfix postfix-ldap

EXPOSE 25

CMD ["/entrypoint.sh"]
#CMD ["/usr/lib/postfix/master", "-c", "/etc/postfix", "-d", "-i"]

RUN ["/usr/bin/newaliases"]

COPY main.cf /etc/postfix/main.cf
COPY entrypoint.sh /entrypoint.sh
