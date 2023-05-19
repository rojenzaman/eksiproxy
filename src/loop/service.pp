server {
	server_name $PROXY;

	include $NGINX_DIR/listen-443.conf;
	include $NGINX_DIR/ssl.conf;
	include	$NGINX_DIR/log.conf;

	location / {
		include $NGINX_DIR/pre-proxy.conf;
		proxy_pass https://$TARGET;
	}
}

