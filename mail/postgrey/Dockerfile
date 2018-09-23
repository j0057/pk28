FROM alpine:3.8
RUN apk --no-cache add postgrey perl-netaddr-ip
CMD ["postgrey", "--inet=0.0.0.0:7000"]
