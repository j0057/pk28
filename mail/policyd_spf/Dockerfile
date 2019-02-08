FROM alpine:3.9

RUN apk --no-cache add policyd-spf-fs socat

RUN addgroup -S spf \
    && adduser -SD -h /var/lib/spf -g policyd-spf -s /sbin/nologin -G spf spf

CMD socat -u unix-recv:/dev/log stdout | cut -c 5- & \
    exec socat tcp4-listen:7001,fork exec:policyd-spf-fs,su=spf

EXPOSE 7001
