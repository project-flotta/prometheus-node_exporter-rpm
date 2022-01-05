VERSION = 1.3.1
RELEASE = 1
DIST_DIR = $(shell pwd)/dist

node_exporter:
	git clone -b v$(VERSION) https://github.com/prometheus/node_exporter.git

rpm-tarball: node_exporter
	cp -R node_exporter.service node_exporter
	tar -czf node_exporter-$(VERSION).tar.gz node_exporter --transform s/node_exporter/node_exporter-$(VERSION)/

rpm-src: rpm-tarball
	mkdir -p $(HOME)/rpmbuild/SOURCES/
	cp node_exporter-$(VERSION).tar.gz $(HOME)/rpmbuild/SOURCES/
	rpmbuild -bs \
		-D "VERSION $(VERSION)" \
		-D "RELEASE $(RELEASE)" \
		./node_exporter.spec

rpm-build: rpm-src
	rpmbuild $(RPMBUILD_OPTS) --rebuild $(HOME)/rpmbuild/SRPMS/node_exporter-$(VERSION)-$(RELEASE).*.src.rpm

rpm: ## Create rpm build
rpm: rpm-build
