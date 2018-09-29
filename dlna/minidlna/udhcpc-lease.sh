#!/bin/sh -x
case "$1" in
    deconfig)
        ip addr flush dev $interface
        ip route flush $dev $interface
        ip link set dev $interface up
        ;;
    bound)
        ip addr add $ip/$mask dev $interface
        ip route add default via $router
        echo "domain $domain" > /etc/resolv.conf
        echo "search $domain" >> /etc/resolv.conf
        echo "nameserver $dns" >> /etc/resolv.conf
        ;;
    renew)
        $0 deconfig
        $0 bound
        ;;
esac
