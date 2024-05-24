#!/bin/sh

set -x

ip -4 rule delete table 51821
ip -4 rule delete table main suppress_prefixlength 0
ip -4 route del 0.0.0.0/0 dev tun0 table 51821
ip -6 rule delete table 51821
ip -6 rule delete table main suppress_prefixlength 0
ip -6 route del ::/0 dev tun0 table 51821

cat >/etc/resolv.conf <<EOF
nameserver 1.1.1.2
EOF
