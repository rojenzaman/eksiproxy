server {
	server_name $PROXY;

	include	$NGINX_DIR/listen-443.conf;
	include $NGINX_DIR/ssl.conf;
	include	$NGINX_DIR/log.conf;

	location / {
		include	$NGINX_DIR/pre-proxy.conf;
		proxy_pass https://$TARGET;
		include $NGINX_DIR/post-proxy.conf;
		#!
		if ! test -z $FRAME; then
		#!

		add_header X-Frame-Options \"ALLOW-FROM $FRAME\";
		add_header Content-Security-Policy \"frame-ancestors $FRAME\";

		#!
		fi
		#!
		include $NGINX_DIR/filter.conf;
	}
}

