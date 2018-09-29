#!/sbin/openrc-run

depend() {
    provide net
}

start() {
    ebegin "Starting udhcpc"
    start-stop-daemon --start --exec /sbin/udhcpc --pidfile /run/dhcpc.pid -- -S -x hostname:$HOSTNAME -p /run/udhcpc.pid
    eend $?
}
