# docker-compose stuff

This repo is for rebuilding my home server into a collection of containers
using docker-compose, in which every container is an adventure in finding out
how to capture logging, how to make it run as not-root, how to make it properly
react to SIGTERM and, if socat was required to pick up the logs, how to deal
with the inherent race condition and process supervision clusterfuck resulting
from running two processes in one container.

## sys

Supporting services for other containers:

- openldap -- because mail containers need to see the same user names and uids.
- cron -- to run periodical stuff in other containers

## dns

- bind9 -- to serve domains to the outside world and also to deal with DNSSEC
  key rotation fun

## vpn

- openvpn\_config -- generate OpenVPN config based on secret magic
- openvpn -- VPN connection
- transmission -- use VPN connection to download torrents for own research and
  study
- privoxy -- to proxy HTTP through VPN tunnel

## mail

- postfix -- SMTP server that authenticates against openldap and delivers mail
  over LTMP to dovecot
- dovecot -- stores mail in maildir
- postgrey -- greylist new SMTP clients
- policyd\_spf -- check SPF headers
- opendkim -- check DKIM headers and also sign outgoing mail headers

## dlna

- minidlna (10x, once for each music collection) -- serve music files to
  streaming box on the home network, this one took **months** to find out how
  to do multicast routing into a container network.

## ops

This stuff is still experimental at the moment.

- elasticsearch
- kibana
- grafana
- influxdb
- chronograf

## more?

- nfs
- syncthing
- nginx
- gitea
- python apps
- certbot (let's encrypt)
