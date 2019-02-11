FROM alpine:3.9

RUN apk --no-cache add bind-tools
RUN apk --no-cache add transmission-daemon transmission-cli

EXPOSE 9091
CMD ip route del default \
    && ip route add default via $(dig +short openvpn) \
    && exec transmission-daemon \
        --foreground \
        --port 9091 \
        --peerport 4614 \
        --no-auth \
        --allowed '127.0.0.1,192.168.178.*,172.17.0.*' \
        --no-portmap \
        --log-info
