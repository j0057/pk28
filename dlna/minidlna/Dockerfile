FROM alpine:3.9

RUN apk --no-cache add socat
RUN apk --no-cache add minidlna

RUN sed -e "/^#root_container=/     s/.*/root_container=${MINIDLNA_ROOT_CONTAINER:-M}/" \
        -e "/^#log_level=/          s/#log_level=\(.*\)=.*\$/log_level=\1=${MINIDLNA_LOG_LEVEL:-info}/" \
        -e "/^#log_dir=/            s!.*!log_dir=${MINIDLNA_LOG_DIR:-/var/log/minidlna}!" \
        -e '/^#user=/               s/.*/user=minidlna/' \
        -e '/^#notify_interval=/    s/.*/notify_interval=20/' \
        -e '/^media_dir=/           s!.*!media_dir=/srv!' \
        -i /etc/minidlna.conf

EXPOSE 8200 1900/udp

CMD socat pipe:/var/log/minidlna/minidlna.log stdout & \
    exec minidlnad -d
