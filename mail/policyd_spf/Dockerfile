FROM alpine:3.8
RUN apk --no-cache upgrade
RUN apk --no-cache add policyd-spf-fs socat
CMD ["socat", "TCP4-LISTEN:7001,fork", "EXEC:/usr/bin/policyd-spf-fs"]
