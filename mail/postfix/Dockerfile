FROM alpine:edge

RUN apk --no-cache add postfix postfix-ldap

EXPOSE 25

ENV PATH="${PATH}:/usr/libexec/postfix"
CMD ["master", "-c", "/etc/postfix", "-i"]

COPY main.cf /etc/postfix/
COPY ldap-aliases.conf /etc/postfix/
