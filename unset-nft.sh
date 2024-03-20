#!/bin/bash

set -uxo pipefail

ip route del local default dev lo table 100
ip rule del fwmark 1 table 100

sysctl -eqw net.bridge.bridge-nf-call-arptables=1
sysctl -eqw net.bridge.bridge-nf-call-ip6tables=1
sysctl -eqw net.bridge.bridge-nf-call-iptables=1

nft flush ruleset

echo nameserver 1.1.1.2 > /etc/resolv.conf
