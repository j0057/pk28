# MiniDLNA aka ReadyMedia

The `minidlna` image requires a directory of music to be volume-mapped into
/opt. Read-only is better! The Docker Compose file bases this on the
environment variable `$MUSIC_PATH`.

## Logging

MiniDLNA insists on logging to a file on disk. It hasn't yet received the memo
that we log to stdout now. Luckily we have `socat` to put a unidirectional FIFO
named pipe on the spot where MiniDLNA will log its stuff, and send all that to
stdout, where Docker can pick it up and process it using its logging driver.

I think this can't be done from a sidecar, because race conditions. The other
option is to do it with init/OpenRC, but that's pretty heavy just to pick up a
log file. I opted to just kick the `socat` process to the background and to
kind of hope for the best. If the socat process dies, there will be no logging.
Don't worry, this is how we run software in 2019.

## Multicast

Fun fact! UPNP/DLNA uses [SSDP][1], the Simple Service Discovery Protocol.
This protocol does discovery by sending an UDP datagram to port 1900 on the
multicast address 239.255.255.250, which opens up a _world_ of hurt, because I
need minidlna to be discoverable from the home LAN.

I learned a whole lot of stuff I wish I hadn't:

For example, you need to allow IGMP through the firewall, it has [IPv4 protocol
number][2] 0x02.

Most multicast packets are sent with an IPv4 TTL of 1, meaning they will not be
routed past the first router. So this is where you use the netfilter `mangle`
table: to hack the TTL from the `PREROUTING` chain.

Still, that's not enough; to make the Linux kernel actually route multicast
packets, you need a multicast routing daemon, such as: igmproxy, mcproxy,
smcroute, mrouted OR pimd. Have fun finding one that works! As far as I
understand it, a multicast routing daemon listens for IGMP packets and
instructs the kernel to route or not route a given multicast address to a
particular interface.

I went with **mrouted** on the host (you can only run it on the host, or maybe
on the host network from a privileged container...) and without any
configuration it seems to do ... _something_, however no multicast packets
arrive as of yet in the minidlna containers. (It seems that both `ip mroute`
and `grep . /proc/net/ip_mr_*` show that ... _something_ is happening).

Of course, if or when all this is working, I'll still need to add a static
route on the router so that clients on the LAN will be able to route into the
docker container networks. This is actually the least of my worries...

So it turns out that normally traffic to a container passes through the `INPUT`
chain of the `filter` table, because the traffic is directly addressed to the
container. However in the case of multicast traffic, it's supposed to reach the
container through the `FORWARD` chain of the `filter` table.

So, the trick is:

- Run `mrouted` on the host
- Give the container network bridge a fixed name and subnet so that it can
  be referenced from an iptables rule
- Allow forwarded traffic to udp/1900 and tcp/8200 to the container network
  using the `DOCKER-USER` chain
- Add a static route on the router so that traffic for the container network
  gets routed through the Docker host
- Disable IGMP snooping on the crappy upstream TP-Link SG-108E 8-port gigabit
  switch, so that it doesn't stop routing the multicast traffic after a few 
  minutes.

Docker, Inc.  helpfully documented on their [Docker and iptables][3] page that
_"All of Docker's iptables rules are added to the DOCKER chain"_, which,
literally, I'm looking at the `FORWARD` chain and it's full of Docker rules.
But whatever. The `FORWARD` chain as configured drops any routed traffic to the
containers. I suppose I can fix it using the `DOCKER-USER` chain. Here's hoping
that I can get Docker to pick a more predictable name for the bridge...

Further reading:

- [Multicast Routing Code in the Linux Kernel][4], Linux Journal, 2002-10-31.
- [Multicast How-to][5], troglobit.com, <2016. (He ominously wishes the
  reader "Good luck!" in setting up multicast routing.)

### Abandoned approach: running containers on the LAN

I first tried to use the macvlan driver, connected to a separate bridge on the
host, and then to use busybox `udhcpc` to get an IP address on the LAN using
DHCP. This mostly works and completely sidesteps the issue of getting multicast
routing to work from the LAN to the container.

However, you need to start the containers manually, because Docker gets
confused if this bridge already exists when Docker starts. So you carefully
have to start Docker first, _then_ start the bridge, and _then_ start the
containers.  Needless to say, this sucks when you need to reboot the server.

To do this you also need either: an init system to manage the `udhcpc` and
`minidlna` processes; or: just punt the supporting process to the background
and hope for the best. I tried to figure out if I could do this with a sidecar,
but had no success. Can you share the network namespace with another container
in Docker?

[1]: https://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol
[2]: https://en.wikipedia.org/wiki/List_of_IP_protocol_numbers
[3]: https://docs.docker.com/network/iptables/
[4]: https://www.linuxjournal.com/article/6070
[5]: http://troglobit.com/howto/multicast/
