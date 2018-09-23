FROM alpine:3.8

RUN apk --no-cache add bind

CMD ["named", "-u", "named", "-f"]

EXPOSE 53 53/udp

COPY named.conf /etc/bind/
