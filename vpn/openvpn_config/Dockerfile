FROM alpine:3.9
RUN apk --no-cache add bash curl libxml2-utils jq
COPY airvpn /usr/local/bin/
CMD ["/usr/local/bin/airvpn", "regenerate_config", "/etc/vpnconfig/vpn.conf"]
