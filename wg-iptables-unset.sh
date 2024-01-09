#!/bin/bash

set -Eeuxo pipefail

iptables -t mangle -D OUTPUT -s 10.0.0.0/24 -j XRAY_SELF
iptables -t mangle -F XRAY_SELF
iptables -t mangle -X XRAY_SELF

iptables -t mangle -D PREROUTING -i wg0 -j XRAY
iptables -t mangle -F XRAY
iptables -t mangle -X XRAY

iptables -t nat -D POSTROUTING -o ens160 -j MASQUERADE

ip route del local default dev lo table 100
ip rule del fwmark 111 table 100
