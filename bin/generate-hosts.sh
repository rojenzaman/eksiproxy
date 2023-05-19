#!/bin/bash

. etc/env.sh
mkdir -p etc/tmp
pp etc/config.conf > etc/tmp/rules.txt

for proxy_domain in $(cat etc/tmp/rules.txt | awk '{print $2}'); do
	echo "${PROXY_BIND} ${proxy_domain}"
done
