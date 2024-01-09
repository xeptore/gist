#!/bin/bash

set -Eeuo pipefail

max_limit='6mbit'

whitelist=('10.0.0.4/32' '10.0.0.7/32' '10.0.0.12/32' '10.0.0.18/32' '10.0.0.22/32' '10.0.0.23/32' '10.0.0.36/32')

exec_cmd() {
    echo "+ $1"
    bash -c "$1"
}

is_limited() {
    local ip needle="$1"
    for ip in "${whitelist[@]}"; do [[ "$ip" == "$needle" ]] && return 1; done
    return 0
}

exec_cmd 'tc qdisc del dev wg0 parent root' || true
exec_cmd 'tc qdisc add dev wg0 parent root handle 1: hfsc default 1'
exec_cmd 'tc class add dev wg0 parent 1: classid 1:1 hfsc ls rate 1gbit'

classid=2
for ip in $(wg show wg0 allowed-ips | cut -f 2); do
	if ( is_limited "$ip" )
	then
		clsid=$(( classid++ ))
		exec_cmd "tc class add dev wg0 parent 1: classid 1:$clsid hfsc ls rate $max_limit ul rate $max_limit"
		exec_cmd "tc filter add dev wg0 parent 1: protocol ip prio 1 u32 match ip dst $ip classid 1:$clsid"
	fi
done
