#!/bin/bash

PORT=5000
LOG=/var/log/bypass-daemon.log
CMD=/opt/git-repo/config/iptables/bypass.sh


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
	$CMD $1
}

if [[ $1 == "start" ]]; then
	start $PORT
else
	nohup "$0" start > $LOG &
fi

