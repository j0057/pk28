#!/sbin/openrc-run

start() {
    configure >/etc/rsyslog.conf
}

configure() {
    echo 'module(load="imuxsock")'

    if [ -n "$RSYSLOG_LISTEN" ]; then
        echo
        echo 'module(load="imudp")'
        echo 'input(type="imudp" port="'"$RSYSLOG_LISTEN"'")'
    fi

    if [ -n "$RSYSLOG_FILES" ]; then
        echo
        echo 'module(load="imfile")'
        echo
    fi

    for filename in $RSYSLOG_FILES; do
        echo "$filename" | sed \
            -e 's/\(.*\):\(.*\):\(.*\):\(.*\)/input(type="imfile" File="\4" Tag="\1" Facility="\2" Severity="\3")/' \
            -e        's/\(.*\):\(.*\):\(.*\)/input(type="imfile" File="\3" Tag="\1" Facility="\2")/' \
            -e               's/\(.*\):\(.*\)/input(type="imfile" File="\2" Tag="\1")/'
    done

    if [ -n "$RSYSLOG_LOCAL" ]; then
        echo
        echo 'module(load="builtin:omfile" fileOwner="root" fileGroup="adm" fileCreateMode="0640")'
        echo
        echo '*.info;mail.none;authpriv.none;cron.none -/var/log/messages'
        echo 'mail.*                                   -/var/log/maillog'
        echo 'authpriv.*                                /var/log/secure'
        echo 'cron.*                                   -/var/log/cron'
    fi

    if [ -n "$RSYSLOG_FORWARD" ]; then
        echo
        echo "*.* @$RSYSLOG_FORWARD"
    fi
}
