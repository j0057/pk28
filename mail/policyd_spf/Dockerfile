FROM alpine:3.8

RUN apk --no-cache add policyd-spf-fs socat

RUN addgroup -S spf \
    && adduser -SD -h /var/lib/spf -g policyd-spf -s /sbin/nologin -G spf spf

USER spf
CMD ["socat", "TCP4-LISTEN:7001,fork", "EXEC:/usr/bin/policyd-spf-fs"]

EXPOSE 7001
