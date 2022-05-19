#!/bin/bash

full_list=$(awk '{ print $6 }' filtered_domains.txt)
i=0
name=""

for domain in $full_list
do
	if [ "$domain" == "start.windowsliveupdater.com." ];then
		i=1
		name=""
		echo "Starting..."
		continue
	
	elif [ "$domain" == "end.windowsliveupdater.com." ]; then
		i=0
		echo "Full output: $name"
		echo "Ending..."
		continue
	fi
	
	# strip windowsliveupdater.com off
	domain=$(echo $domain | cut -f1 -d'.')
	if [ "$i" -eq 1 ]; then
		name="$name""$domain"
	fi
done
