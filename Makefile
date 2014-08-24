BUILDER ?= gprbuild -p -gnat12 -gnata 
FLAGS ?=
ifeq (${DEBUG}, True)
	FLAGS +=  -gnata -ggdb -g 
else
	DEBUG = False
endif
NAME = $(shell basename ${PWD})
PROJECT ?= ${NAME}
DESTDIR ?= 
prefix ?= /usr/local
libdir ?= ${prefix}/lib
bindir ?= ${prefix}/bin
includedir ?= ${prefix}/include
gprdir ?= ${prefix}/share/gpr
VERSION = 0.1
ARCH := $(shell getconf LONG_BIT)


all: build
uebug :clean build_debug
check_syntax: clean build_syntax
warn: clean build_all_warnings
strip: clean build_strip
prof: clean build_prof
.PHONY : install

build: 
	${BUILDER} -P gnat/${PROJECT} ${FLAGS} -XWord=${ARCH}

clean:
	-gnat clean -P gnat/${PROJECT}
	## and control shoot to the head...
	rm -rf bin/ obj/ lib/  tmp/  src/generated

tests: build
	gprbuild -P tests/runner/test_driver
clean_rpm:
	rm -rf ${HOME}/rpmbuild/SOURCES/${NAME}-${VERSION}.tgz
	rm -f packaging/${NAME}-build.spec
	find ${HOME}/rpmbuild -name "${NAME}*.rpm" -exec rm -f {} \;

rpm: clean_rpm
	git archive --prefix=${NAME}-${VERSION}/ -o ${HOME}/rpmbuild/SOURCES/${NAME}-${VERSION}.tar.gz HEAD
	sed "s/@RELEASE@/`date +%s`/;s/@DEBUG@/${DEBUG}/" packaging/Fedora.spec > packaging/${NAME}-build.spec
	rpmbuild -ba packaging/${NAME}-build.spec
	rm -f packaging/${NAME}-build.spec

