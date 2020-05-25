#!/bin/sh
monitor() {
	sleep 1s
	bilihp_change
	busybox md5sum "$conf_path" > "$conf_md5_path" 2>/dev/null
	while true
	do
		sleep 20s
		# md5sum conf
		local md5_status
		busybox md5sum -cs $conf_md5_path 2>/dev/null
		md5_status=$?
		if [ $md5_status -ne 0 ]; then
			logger -t bilihp The configuration has changed
			bilihp_change
			busybox md5sum "$conf_path" > "$conf_md5_path" 2>/dev/null
		fi

		# check bilihp status
		local bilihp_pid=$(busybox ps -w | grep $bilihp_path | grep -v grep | grep -v 'bilihp_monitor.sh' | awk '{print $1}')
		if [ -z "$bilihp_pid" ]; then
			/etc/init.d/bilihp restart
		fi
	done
}

bilihp_change() {
	local id
	id=$(awk -F '=' '/\[c2c\]/{a=1}a==1&&$1~/id/{print $2;exit}' "$conf_path"|awk '$1=$1')
	[ -n "$id" ] || id='0'
	uci set bilihp.conf.id="$id"

	local name
	name=$(awk -F '=' '/\[c2c\]/{a=1}a==1&&$1~/name/{print $2;exit}' "$conf_path"|awk '$1=$1')
	[ -n "$name" ] && uci set bilihp.conf.name="$name"

	local password
	password=$(awk -F '=' '/\[c2c\]/{a=1}a==1&&$1~/password/{print $2;exit}' "$conf_path"|awk '$1=$1')
	[ -n "$password" ] && uci set bilihp.conf.password="$password"
	uci commit bilihp
}

bilihp_path=$1
conf_path=$2
conf_md5_path=$3
monitor
