.PHONY: /etc/hosts

generate: lib/pp clean
	bin/build.sh

install-pp lib/pp:
	bin/install-pp.sh -d lib/objs -i

uninstall-pp:
	bin/install-pp.sh -d lib/objs -r

clean:
	rm -rf output/*.conf etc/tmp

clean-all: clean
	rm -rf lib/objs

format-pp:
	nginxbeautifier src/loop/*.uppconf src/settings/*.uppconf

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

