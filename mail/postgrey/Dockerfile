FROM alpine:3.9

RUN apk --no-cache add socat
RUN apk --no-cache add postgrey perl-netaddr-ip

EXPOSE 7000

CMD socat -u unix-recv:/dev/log stdout | cut -c 5- & \
    exec postgrey --inet=0.0.0.0:7000
