#!/bin/bash

. etc/env.sh
lib/ssl.sh -k ${SSL_CERT_KEY} -p ${SSL_CERT} -d ${DOMAIN}
