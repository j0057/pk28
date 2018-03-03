#!/bin/sh
case "$1" in
    start)
        exec /usr/sbin/dovecot -F -c /etc/dovecot/dovecot.conf
        ;;
    create-user)
        uid_gid=$2
        login=$3
        full_name=$4
        mail_pass=$5
        set -x
        grep -vq '^$login:' /etc/group \
            && addgroup -g $uid_gid $login
        grep -vq '^$login:' /etc/passwd \
            && adduser -h /home/$login -g "$full_name" -s ash -D -u $uid_gid $login $login
        { test ! -f /etc/dovecot/db/users || grep -vq '^$login:' /etc/dovecot/db/users ; } \
            && echo "$login:{PLAIN}$mail_pass:$uid_gid:$uid_gid::/home/$login" >> /etc/dovecot/db/users
        ;;
    *)
        exec $@
        ;;
esac
