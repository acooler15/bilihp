#!/bin/sh

limit_size_log() {
	if [ ! -f "$log_path" ]; then
		touch $log_path
	fi
	local filesize=`ls -l $log_path | awk '{ print $5 }'`
	if [ $filesize -gt $log_max_size ]; then
		cat /dev/null > $log_path
	fi

}

# running
log_path=$1
log_max_size=$(($2*1024))
while true
do
	limit_size_log
	sleep 60s
done
