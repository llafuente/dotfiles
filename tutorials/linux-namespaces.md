# know current namespace

```
ip netns
#or
ls /var/run/netns
```

# remove network from a process

```
ip netns add app
ip netns exec app /bin/bash

# cleanup
ip netns del app
```

# remove outside network (isolated loopback)

```
ip netns add app
ip netns exec app ip link set dev lo up
ip netns exec app /bin/bash

# cleanup
ip netns del app
```

# Remove outside network with access to host loopback (via 10.1.1.1)

```
ip netns add ns-app
ip netns exec ns-app ip link set lo up

# create virtual network root(0) ns(1)
ip link add veth-0 type veth peer name veth-peer-0
ip link set veth-peer-0 netns ns-app

# assign ip and start to host
ip addr add 10.1.1.1/24 dev veth-0
ip link set veth-0 up

# assign ip and start guest
ip netns exec ns-app ip addr add 10.1.1.2/24 dev veth-peer-0
ip netns exec ns-app ip link set veth-peer-0 up


ip netns exec ns-app ip route add default via 10.1.1.1


ip netns exec ns-app /bin/bash


# cleanup
ip netns del ns-app
ip link del veth-0
```

**NOTE** start a process before create the ns even with 0.0.0.0
it won't get any traffic.


# create namesever with world access (same as eth0)

Same as the above +

```
iptables -P FORWARD DROP
iptables -F FORWARD
iptables -t nat -F
#iptables -t nat -A POSTROUTING -s 10.1.1.2/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.1.1.1/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o veth-0 -j ACCEPT
iptables -A FORWARD -o eth0 -i veth-0 -j ACCEPT
```

# display routing table

```
ip route show
```
