FROM alpine:3.9

RUN apk --no-cache add socat
RUN apk --no-cache add postfix postfix-ldap

EXPOSE 25

ENV PATH="${PATH}:/usr/libexec/postfix"
CMD socat -u unix-recv:/dev/log stdout | cut -c 5- & \
    exec master -c /etc/postfix -i

COPY main.cf /etc/postfix/
COPY ldap-aliases.conf /etc/postfix/
