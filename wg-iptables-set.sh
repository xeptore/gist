#!/bin/bash

set -Eeuxo pipefail

iptables -t nat -A POSTROUTING -o ens160 -j MASQUERADE

ip route add local default dev lo table 100
ip rule add fwmark 111 table 100

iptables -t mangle -N XRAY
iptables -t mangle -A XRAY -d 10.0.0.0/8 -j RETURN
iptables -t mangle -A XRAY -d 100.64.0.0/10 -j RETURN
iptables -t mangle -A XRAY -d 127.0.0.0/8 -j RETURN
iptables -t mangle -A XRAY -d 169.254.0.0/16 -j RETURN
iptables -t mangle -A XRAY -p udp -d 172.16.0.1/32 --dport 53 -j TPROXY --on-port 12345 --on-ip 127.0.0.1 --tproxy-mark 111
iptables -t mangle -A XRAY -d 172.16.0.0/12 -j RETURN
iptables -t mangle -A XRAY -d 192.0.0.0/24 -j RETURN
iptables -t mangle -A XRAY -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A XRAY -d 240.0.0.0/4 -j RETURN
iptables -t mangle -A XRAY -d 255.255.255.255/32 -j RETURN
# remove the following 2 lines on the server
#iptables -t mangle -A XRAY -d 192.168.0.0/16 -p tcp -j RETURN
#iptables -t mangle -A XRAY -d 192.168.0.0/16 -p udp -j RETURN
iptables -t mangle -A XRAY -p tcp -j TPROXY --on-port 12345 --on-ip 127.0.0.1 --tproxy-mark 111
iptables -t mangle -A XRAY -p udp -j TPROXY --on-port 12345 --on-ip 127.0.0.1 --tproxy-mark 111
iptables -t mangle -A PREROUTING -i wg0 -j XRAY

iptables -t mangle -N XRAY_SELF
iptables -t mangle -A XRAY_SELF -d 10.0.0.0/8 -j RETURN
iptables -t mangle -A XRAY_SELF -d 100.64.0.0/10 -j RETURN
iptables -t mangle -A XRAY_SELF -d 127.0.0.0/8 -j RETURN
iptables -t mangle -A XRAY_SELF -d 169.254.0.0/16 -j RETURN
iptables -t mangle -A XRAY_SELF -p udp -d 172.16.0.1/32 --dport 53 -j MARK --set-mark 111
iptables -t mangle -A XRAY_SELF -d 172.16.0.0/12 -j RETURN
iptables -t mangle -A XRAY_SELF -d 192.0.0.0/24 -j RETURN
iptables -t mangle -A XRAY_SELF -d 224.0.0.0/4 -j RETURN
iptables -t mangle -A XRAY_SELF -d 240.0.0.0/4 -j RETURN
iptables -t mangle -A XRAY_SELF -d 255.255.255.255/32 -j RETURN
# remove the following 2 lines on real server
#iptables -t mangle -A XRAY_SELF -d 192.168.0.0/16 -p tcp -j RETURN
#iptables -t mangle -A XRAY_SELF -d 192.168.0.0/16 -p udp -j RETURN
iptables -t mangle -A XRAY_SELF -m mark --mark 2 -j RETURN
iptables -t mangle -A XRAY_SELF -p tcp -j MARK --set-mark 111
iptables -t mangle -A XRAY_SELF -p udp -j MARK --set-mark 111
iptables -t mangle -A OUTPUT -s 10.0.0.0/24 -j XRAY_SELF
