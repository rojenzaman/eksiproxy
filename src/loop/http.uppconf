server {
	include $NGINX_DIR/listen-80.conf;
	server_name $proxy_domain;
	return 301 https://\$host\$request_uri;
}

