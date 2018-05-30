FROM alpine:3.7

RUN apk --no-cache upgrade
RUN apk --no-cache add openvpn

RUN mkdir -m 755 -p /dev/net && mknod /dev/net/tun c 10 200 && chmod -v 666 /dev/net/tun

COPY openvpn.conf /etc/openvpn/
COPY *.crt /etc/openvpn/
COPY *.key /etc/openvpn/

STOPSIGNAL SIGTERM
CMD iptables -t nat -A POSTROUTING -o tun0 -s 172.16.0.0/12 -j MASQUERADE \
    && exec openvpn --config /etc/openvpn/openvpn.conf --remote 213.152.161.169

#*filter
#:INPUT ACCEPT [0:0]
#:FORWARD ACCEPT [0:0]
#:OUTPUT ACCEPT [0:0]
#--append OUTPUT --out-interface tun0 --jump ACCEPT
#--append OUTPUT --out-interface net0+ --destination 213.152.161.19 --jump ACCEPT
#--append OUTPUT --out-interface net0+ --destination 10.103.0.0/24 --jump ACCEPT
#--append OUTPUT --out-interface net0+ --destination 192.168.178.0/24 --jump ACCEPT
#--append OUTPUT --out-interface lo --destination 127.0.0.0/8 --jump ACCEPT
#--append OUTPUT --jump REJECT --reject-with icmp-net-prohibited
