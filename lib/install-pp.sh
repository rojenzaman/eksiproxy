#!/bin/bash

PP=https://adi.onl/pp/pp@1.0.11.tgz

usage() {
	echo "Usage: ${BASH_SOURCE[0]} -d <working directory>"
	echo "   -i install"
	echo "   -r uninstall"
	exit 1
} ; if [[ "$#" -lt 3 ]]; then usage; fi

while getopts ":d:ir" opt; do
	case "${opt}" in
		d) working_directory="$(realpath "${OPTARG}")" ; dflag=true ;;
		i) iflag="true" ;;
		r) rflag="true" ;;
		:) echo "Error: -${OPTARG} requires an argument." ; usage ;;
		*) usage ;;
	esac
done

if [[ ! "${dflag}" ]]; then echo "-d option must be specified"; exit 1; fi

if [[ "${rflag}" == "true" ]]; then
	make -C "${working_directory}/pp" uninstall
fi

if [[ "${iflag}" == "true" ]]; then
	mkdir -p "${working_directory}"
	wget -O "${working_directory}/pp.tar.gz" "${PP}"
	tar xzvf "${working_directory}/pp.tar.gz" --directory "${working_directory}"
	make -C "${working_directory}/pp" install
fi
