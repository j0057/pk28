FROM alpine:edge

RUN apk --no-cache add postfix postfix-ldap

EXPOSE 25

CMD ["/usr/libexec/postfix/master", "-c", "/etc/postfix", "-i"]

RUN ["/usr/bin/newaliases"]

COPY main.cf /etc/postfix/main.cf
