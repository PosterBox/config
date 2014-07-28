#!/bin/bash

PORT=5000


function start {
nc -kl $1 | while IFS=, read -a p; do
	IP=${p[0]}
	echo receive bypass request for $IP
	if check_ip $IP; then
		process $IP
	fi	
done
}

function check_ip {
	[[ -n `echo $1 | grep -P "(\d{1,3}\.){3}\d{1,3}"` ]]
}

function process {
	echo add IP $1
	./bypass.sh $1
}


start $PORT
