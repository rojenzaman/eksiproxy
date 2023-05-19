.PHONY: /etc/hosts

generate: /usr/local/bin/pp clean
	bin/build.sh

install-pp /usr/local/bin/pp:
	lib/install-pp.sh -d lib/objs -i

uninstall-pp:
	lib/install-pp.sh -d lib/objs -r

clean:
	rm -rf output/*.conf etc/tmp

clean-all: clean
	rm -rf lib/objs

format-pp:
	nginxbeautifier src/loop/*.pp src/settings/*.pp

format-sh:
	beautysh --tab lib/*.sh bin/*.sh

ssl:
	bin/generate-ssl.sh

hosts /etc/hosts:
	@bin/generate-hosts.sh 2>/dev/null

install: uninstall
	@bin/install.sh

uninstall:
	@bin/uninstall.sh

all: generate install

