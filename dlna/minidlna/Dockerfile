FROM alpine:3.8

#
# openrc
#

RUN apk add --no-cache openrc \
    && sed -i 's/^\(tty\d\:\:\)/#\1/g' /etc/inittab \
    && sed -i \
        -e 's/#rc_sys=".*"/rc_sys="docker"/g' \
        -e 's/#rc_env_allow=".*"/rc_env_allow="\*"/g' \
        -e 's/#rc_crashed_stop=.*/rc_crashed_stop=NO/g' \
        -e 's/#rc_crashed_start=.*/rc_crashed_start=YES/g' \
        -e 's/#rc_provide=".*"/rc_provide="loopback"/g' \
        /etc/rc.conf \
    && rm -f /etc/init.d/hwdrivers \
            /etc/init.d/hwclock \
            /etc/init.d/hwdrivers \
            /etc/init.d/modules \
            /etc/init.d/modules-load \
            /etc/init.d/modloop \
    && sed -i 's/\tcgroup_add_service/\t#cgroup_add_service/g' /lib/rc/sh/openrc-run.sh \
    && sed -i 's/VSERVER/DOCKER/Ig' /lib/rc/sh/init.sh

CMD ["init"]

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
RUN sed -i -e 's/^#root_container=/root_container=M/' /etc/minidlna.conf

RUN rc-update add minidlna default
EXPOSE 8200 1900/udp
