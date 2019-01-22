FROM joostm/alpine_rsyslog:3.8

#
# udhcpc (to join the home network)
#

COPY udhcpc-init.sh /etc/init.d/udhcpc
COPY udhcpc-lease.sh /usr/share/udhcpc/default.script
RUN rc-update add udhcpc default

#
# minidlna
#

RUN apk add --no-cache minidlna
RUN sed -i -e 's/^#root_container=.*$/root_container=M/' /etc/minidlna.conf

RUN rc-update add minidlna default
EXPOSE 8200 1900/udp
