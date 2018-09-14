FROM alpine:3.8
RUN apk --no-cache upgrade
RUN apk --no-cache add postfix
COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
