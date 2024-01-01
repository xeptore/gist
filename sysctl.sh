#!/bin/bash

sysctl -w net.ipv4.ip_forward=1
sysctl -w net.core.default_qdisc=fq
sysctl -w net.ipv4.tcp_congestion_control=bbr
sysctl -w net.ipv4.tcp_timestamps=0
sysctl -w net.ipv4.tcp_rmem='4096 87380 10485760'
sysctl -w net.ipv4.tcp_wmem='4096 87380 10485760'
sysctl -w net.core.rmem_max=10485760
sysctl -w net.core.wmem_max=10485760
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
