#!/bin/sh

process_name=$1
config_file=$2
supervisor_service_name=$3

if [ ! -e $config_file ]; then
	echo $config_file does not exist
	exit 1
fi

while :
do
	while inotifywait -e access $config_file; do
		$process_name -t $config_file
		status=$?
		echo $status
		if [ $status = 0 ]; then
			supervisorctl restart $supervisor_service_name
			echo "Process restarted as $config_file was modified."
                else
			echo "Process restart failed. There is some issue in $config_file."
		fi
	done
done
