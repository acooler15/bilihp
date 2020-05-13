#!/bin/sh
monitor() {
	while true
	do
		sleep 60s
		local bilihp_pid=$(busybox ps -w | grep $bilihp_path | grep -v grep | grep -v 'bilihp_monitor.sh' | awk '{print $1}')
		if [ -z "$bilihp_pid" ]; then
			/etc/init.d/bilihp restart
		fi
	done
}
bilihp_path=$1
monitor