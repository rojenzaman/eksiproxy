#!/bin/bash

key_file=""
pem_file=""
domain=""

while getopts ":k:p:d:" opt; do
	case $opt in
		k)
			key_file="$OPTARG"
			;;
		p)
			pem_file="$OPTARG"
			;;
		d)
			domain="$OPTARG"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
		:)
			echo "Option requires an argument: -$OPTARG" >&2
			exit 1
			;;
	esac
done

shift $((OPTIND -1))

if [ -z "$key_file" ] || [ -z "$pem_file" ] || [ -z "$domain" ]; then
	echo "Error: -k, -p, and -d options are required."
	echo $'\n'"Usage: $BASH_SOURCE -k key_file -p pem_file -d domain"
	exit 1
fi

echo "Generating SSL key file: $key_file"
openssl genrsa -out "$key_file" 2048

echo "Generating SSL pem file: $pem_file"
openssl req -new -x509 -sha256 -key "$key_file" -out "$pem_file" -days 365 -subj "/CN=$domain"

echo "SSL key and pem files have been generated."
