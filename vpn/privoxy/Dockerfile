FROM alpine:3.9

RUN apk --no-cache add bind-tools
RUN apk --no-cache add privoxy

RUN sed -i '/^listen-address / s/^.*$/listen-address :8118/' /etc/privoxy/config

EXPOSE 8118

#CMD gw=$(ip route get 1.1.1.1 | cut -d ' ' -f 3) \
#    && ip route del default \
#    && ip route add default via $(dig +short openvpn) \
#    && ip route add 10.0.0.0/8 via $gw \
#    && ip route add 172.16.0.0/12 via $gw \
#    && ip route add 192.168.0.0/16 via $gw \
#    && exec privoxy --no-daemon /etc/privoxy/config

CMD ip route del default \
    && ip route add default via $(dig +short openvpn) \
    && exec privoxy --no-daemon /etc/privoxy/config
