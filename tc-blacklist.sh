#!/bin/bash

set -Eeuo pipefail

max_limit='4mbit'

limited=('10.0.0.39/32' '10.0.0.17/32')

exec_cmd() {
    echo "+ $1"
    bash -c "$1"
}

is_limited() {
    local ip needle="$1"
    for ip in "${limited[@]}"; do [[ "$ip" == "$needle" ]] && return 0; done
    return 1
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
