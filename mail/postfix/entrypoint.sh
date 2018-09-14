#!/bin/sh
stop_postfix() {
    pkill -TERM master
    for x in {1..5}; do
        ! pgrep master 1> /dev/null && break
        sleep 1
    done
    if pgrep master 1> /dev/null; then
        pkill -KILL master
    fi
}
trap stop_postfix SIGTERM
/usr/lib/postfix/master -c /etc/postfix -d &
wait $!
