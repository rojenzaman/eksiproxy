#!/bin/bash

PP_URL=https://github.com/rojenzaman/pp/archive/refs/heads/master.zip
PP_FILE=master.zip
PP_DIR=pp-master
PP_BIN=pp

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
	rm "lib/${PP_BIN}"
	make -C "${working_directory}/${PP_DIR}" clean
fi

if [[ "${iflag}" == "true" ]]; then
	mkdir -p "${working_directory}"
	wget -O "${working_directory}/${PP_FILE}" "${PP_URL}"
	unzip -o "${working_directory}/${PP_FILE}" -d "${working_directory}"
	make -C "${working_directory}/${PP_DIR}"
	mkdir -p lib
	cp "${working_directory}/${PP_DIR}/${PP_BIN}" "lib"
fi
