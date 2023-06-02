export DOMAIN=localhost.localdomain
export NGINX_DIR=/etc/nginx/${DOMAIN}

export PROXY_BIND=0.0.0.0
export PROXY_ACCESS_LOG=/var/log/nginx/${DOMAIN}.access.log
export PROXY_ERROR_LOG=/var/log/nginx/${DOMAIN}.error.log
export SSL_CERT=/etc/ssl/certs/${DOMAIN}.pem
export SSL_CERT_KEY=/etc/ssl/private/${DOMAIN}.key
