#!/bin/bash

set -uxo pipefail

ip route add local default dev lo table 100
ip rule add fwmark 1 table 100

sysctl -eqw net.bridge.bridge-nf-call-arptables=0
sysctl -eqw net.bridge.bridge-nf-call-ip6tables=0
sysctl -eqw net.bridge.bridge-nf-call-iptables=0

nft -f /home/nerd/sing-box/nftables.rules

echo nameserver 127.0.1.1 > /etc/resolv.conf
