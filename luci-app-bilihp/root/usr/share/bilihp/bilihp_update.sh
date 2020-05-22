#!/bin/sh
update() {
	local bilihp_base_path=$1
	local app_name=$2
	local base_url=$3
	local base_url2=$4
	local bilihp_index_path="$bilihp_base_path""index"
	local bilihp_timestamp_path="$bilihp_base_path""timestamp"
	while true
	do
		touch $bilihp_index_path
		curl $base_url -s -f -o $bilihp_index_path >/dev/null 2>&1 || \
		curl $base_url2 -s -f -o $bilihp_index_path >/dev/null 2>&1 || \
		wget $base_url -q -O $bilihp_index_path >/dev/null 2>&1 || \
		wget $base_url2 -q -O $bilihp_index_path >/dev/null 2>&1
		local index_filesize
		index_filesize=`ls -l $bilihp_index_path | awk '{ print $5 }'`
		if [ $index_filesize -gt 0 ]; then
			local timestamp
			# run function date2timestamp
			date2timestamp
			if [ -f "$bilihp_timestamp_path" ]; then
				local stimestamp=$(cat $bilihp_timestamp_path)
				[ -z "$stimestamp" ] && stimestamp=0
				if [ $timestamp -gt $stimestamp ]; then
					logger -t bilihp "A new version has been found and will be updated."
					/etc/init.d/bilihp restart
				fi
			else
				touch $bilihp_timestamp_path
				echo "$timestamp" > "$bilihp_timestamp_path"
			fi
		fi
		rm -rf "$bilihp_index_path"
		sleep 15m
	done
}

date2timestamp() {

	local sdatetime=$(cat "$bilihp_index_path" | grep "$app_name" | awk '{print $3,$4}')
	local sdate=$(echo "$sdatetime" | awk '{print $1}')
	local stime=$(echo "$sdatetime" | awk '{print $2}')
	local mon=$(echo "$sdate" | awk -F '-' '{print $2}')
	mon=$(echo $mon | awk '{gsub(/Jan/,"01");print $0}')
	mon=$(echo $mon | awk '{gsub(/Feb/,"02");print $0}')
	mon=$(echo $mon | awk '{gsub(/Mar/,"03");print $0}')
	mon=$(echo $mon | awk '{gsub(/Apr/,"04");print $0}')
	mon=$(echo $mon | awk '{gsub(/May/,"05");print $0}')
	mon=$(echo $mon | awk '{gsub(/Jun/,"06");print $0}')
	mon=$(echo $mon | awk '{gsub(/Jul/,"07");print $0}')
	mon=$(echo $mon | awk '{gsub(/Aug/,"08");print $0}')
	mon=$(echo $mon | awk '{gsub(/Sep/,"09");print $0}')
	mon=$(echo $mon | awk '{gsub(/Oct/,"10");print $0}')
	mon=$(echo $mon | awk '{gsub(/Nov/,"11");print $0}')
	mon=$(echo $mon | awk '{gsub(/Dec/,"12");print $0}')
	local tdate
	tdate="$(echo $sdate | awk -F '-' '{print $3}')""-"
	tdate="$tdate""$mon""-"
	tdate="$tdate""$(echo $sdate | awk -F '-' '{print $1}')"" "
	tdate="$tdate""$stime"
	timestamp=$(date -d "$tdate" +%s)

}
update "$1" "$2" "$3" "$4"