#!/bin/sh -ex
while [ ! -f /etc/vpnconfig/vpn.conf ]; do
    sleep 0.5
done
. /etc/vpnconfig/vpn.conf
iptables -t filter -A OUTPUT -o tun0 -j ACCEPT -m comment --comment 'tunneled traffic'
iptables -t filter -A OUTPUT -o eth0+ -d $VPN_IP -p tcp --dport 443 -j ACCEPT -m comment --comment 'to vpn provider'
iptables -t filter -A OUTPUT -o eth0+ -d 10.0.0.0/8 -j ACCEPT -m comment --comment 'to local /8 net'
iptables -t filter -A OUTPUT -o eth0+ -d 172.16.0.0/12 -j ACCEPT -m comment --comment 'to local /12 net'
iptables -t filter -A OUTPUT -o eth0+ -d 192.168.0.0/16 -j ACCEPT -m comment --comment 'to local /16 net'
iptables -t filter -A OUTPUT -o lo -d 127.0.0.0/8 -j ACCEPT -m comment --comment 'to localhost'
iptables -t filter -A OUTPUT -j REJECT --reject-with icmp-net-prohibited -m comment --comment 'drop everything else'
iptables -t nat -A POSTROUTING -o tun0 -s 172.16.0.0/12 -j MASQUERADE -m comment --comment 'masquerade traffic when acting as gateway'
exec openvpn --config /etc/openvpn/openvpn.conf --remote $VPN_IP
