FROM alpine:3.9

RUN apk --no-cache add openvpn

RUN mkdir -m 755 -p /dev/net && mknod /dev/net/tun c 10 200 && chmod -v 666 /dev/net/tun

COPY openvpn.conf /etc/openvpn/
COPY *.crt /etc/openvpn/
COPY *.key /etc/openvpn/
COPY entrypoint.sh /

STOPSIGNAL SIGTERM
CMD ["/entrypoint.sh"]
