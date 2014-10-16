include $(PQ_FACTORY)/factory.mk

pq_module_name := libffi-3.1
pq_module_file := $(pq_module_name).tar.gz

build-stamp: stage-stamp
	$(MAKE) -C $(pq_module_name) && \
	$(MAKE) -C $(pq_module_name) install DESTDIR=$(stage_dir) && \
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	(cd $(pq_module_name) && ./configure --prefix=$(part_dir)) && touch $@

patch-stamp: unpack-stamp fix-pkgconfig.patch
	patch -p0 < $(source_dir)/fix-pkgconfig.patch
	touch $@

unpack-stamp:
	tar -xf $(source_dir)/$(pq_module_file) && touch $@
