FROM alpine:3.7
RUN apk --no-cache upgrade
RUN apk --no-cache add opendkim
RUN install -o opendkim -g opendkim -m 700 -d /run/opendkim
