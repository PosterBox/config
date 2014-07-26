#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -t nat -F


iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.20.254:80
iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to-destination 192.168.20.254:53

iptables -I POSTROUTING -t nat -o eth0 -j MASQUERADE

iptables -t nat -L
