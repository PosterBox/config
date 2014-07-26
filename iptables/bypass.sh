#!/bin/bash

IP=${1:?Need an IP}

echo bypass $IP

function is_exist {
	[[ -n `iptables -t nat -L | egrep "^ACCEPT.+ $1 "` ]]
}

function bypass {
	iptables -t nat -I PREROUTING -s $IP -j ACCEPT
}

if ! is_exist $1; then
	bypass $1
fi

iptables -t nat --list
