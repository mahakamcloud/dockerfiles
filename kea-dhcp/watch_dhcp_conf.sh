#!/bin/sh

while :
do
	while inotifywait -e modify /usr/local/etc/kea/kea-dhcp-ddns.conf; do
		/usr/local/sbin/kea-dhcp-ddns -t /usr/local/etc/kea/kea-dhcp-ddns.conf
		status=$?
		echo $status
		if [ $status = 0 ]; then
			supervisorctl restart kea-dhcp-ddns
			echo "Process restarted as /usr/local/etc/kea/kea-dhcp-ddns.conf was modified."
		else 
			echo "Process restart failed. There is some issue in /usr/local/etc/kea/kea-dhcp-ddns.conf"
		fi
	done
done