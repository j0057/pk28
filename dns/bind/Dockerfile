FROM alpine:3.9

RUN apk --no-cache add bind

CMD ["named", "-u", "named", "-g"]

EXPOSE 53 53/udp

COPY named.conf /etc/bind/
