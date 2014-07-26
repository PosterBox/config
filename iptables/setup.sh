#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward

function clear_all_rules {
	iptables -t nat -F
}

function redirect_http {
	iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.20.254:80
}

function redirect_dns {
	iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to-destination 192.168.20.254:53
}

function forward_packet {
	iptables -I POSTROUTING -t nat -o eth0 -j MASQUERADE
}

function list_rules {
	iptables -t nat -L
}

clear_all_rules
redirect_http
if [[ $1 == "standalone" ]]; then
	redirect_dns
else
	forward_packet
fi
list_rules
