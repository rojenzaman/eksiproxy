#!/usr/bin/env bash

. etc/env.sh
mkdir -p etc/tmp
pp etc/config.conf > etc/tmp/rules.txt

while IFS= read -r line; do
	export PROXY=$(echo ${line} | awk '{print $2}')
	export TARGET=$(echo ${line} | awk '{print $1}')
	FORMAT=$(echo ${line} | awk '{print $3}')
	if [[ ${FORMAT} == "service" ]]; then
		pp src/loop/service.pp >> output/service.conf
	fi
done < etc/tmp/rules.txt && echo "src/loop/service.pp >> output/service.conf"

while IFS= read -r line; do
	export PROXY=$(echo ${line} | awk '{print $2}')
	export TARGET=$(echo ${line} | awk '{print $1}')
	export FRAME=$(echo ${line} | awk '{print $4}')
	FORMAT=$(echo ${line} | awk '{print $3}')
	if [[ ${FORMAT} == "main" ]]; then
		pp src/loop/main.pp >> output/main.conf
	fi
done < etc/tmp/rules.txt && echo "src/loop/main.pp >> output/main.conf"

for proxy_domain in $(cat etc/tmp/rules.txt | awk '{print $2}'); do
	export proxy_domain="${proxy_domain}"
	pp src/loop/http.pp >> output/http.conf
done && echo "src/loop/http.pp >> output/http.conf"

for pp_file in $(find src/ -path 'src/loop' -prune -o -name "*.pp" -print); do
	pp "${pp_file}" > "output/$(basename "${pp_file%.pp}.conf")" && echo "${pp_file}" " >> " "output/$(basename "${pp_file%.pp}.conf")"
done

while IFS= read -r line; do
	from=$(echo "$line" | awk '{print $1}')
	to=$(echo "$line" | awk '{print $2}')
	echo "subs_filter \"${from}\" \"${to}\";" >> output/libre.conf
done < etc/libre.txt && echo "etc/libre.txt >> output/libre.conf"

while IFS= read -r line; do
	from=$(echo "$line" | awk '{print $1}')
	to=0.0.0.0
	echo "subs_filter \"${from}\" \"${to}\";" >> output/blacklist.conf
done < etc/blacklist.txt && echo "etc/blacklist.txt >> output/blacklist.conf"

while IFS= read -r line; do
	from=$(echo "$line" | awk '{print $1}')
	to=$(echo "$line" | awk '{print $2}')
	echo "subs_filter \"${from}\" \"${to}\";" >> output/proxy-filter.conf
done < etc/tmp/rules.txt && echo "etc/tmp/rules.txt >> output/proxy-filter.conf"
