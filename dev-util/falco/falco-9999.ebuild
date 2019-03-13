# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULES_OPTIONAL_USE=modules
inherit git-r3 linux-mod bash-completion-r1 cmake-utils flag-o-matic

DESCRIPTION="A system exploration and troubleshooting tool"
HOMEPAGE="https://www.sysdig.org/"
EGIT_REPO_URI="https://github.com/falcosecurity/falco"
CMAKE_USE_DIR="${S}/falco"
CMAKE_VERBOSE=1
EGIT_BRANCH=dev

LICENSE="Apache-2.0
	modules? ( || ( MIT GPL-2 ) )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl +modules"

RDEPEND="
	app-misc/jq:0=
	dev-cpp/tbb:0=
	dev-cpp/nlohmann_json
	dev-lua/lpeg
	dev-libs/libyaml[static-libs]
	www-servers/civetweb
	dev-lua/lyaml[static-libs]
	dev-lang/luajit:2=
	>=dev-libs/jsoncpp-0.6_pre:0=
	dev-libs/libb64:0=
	dev-libs/protobuf:0=[static-libs]
	net-dns/c-ares:0=[static-libs]
	=net-libs/grpc-1.13.0-r1[static-libs]
	sys-libs/ncurses:0=[static-libs]
	sys-libs/zlib:0=[static-libs]
	libressl? ( dev-libs/libressl:0= )
	!libressl? ( dev-libs/openssl:0= )
	net-misc/curl:0="
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/os-headers"

# needed for the kernel module
CONFIG_CHECK="HAVE_SYSCALL_TRACEPOINTS ~TRACEPOINTS"

pkg_pretend() {
	linux-mod_pkg_setup
}

pkg_setup() {
	linux-mod_pkg_setup
}


src_unpack() {
	git-r3_fetch https://github.com/draios/sysdig
	git-r3_fetch ${EGIT_REPO_URI}

	git-r3_checkout https://github.com/draios/sysdig "${S}/sysdig"
	git-r3_checkout ${EGIT_REPO_URI} "${S}/falco"
}

src_prepare() {
	sed -i -e 's:find_library(LYAML_LIB NAMES yaml.a:find_library(LYAML_LIB NAMES yaml.a PATHS /usr/lib64/lua/5.1:' falco/CMakeLists.txt || die
	sed -i -e 's:lpeg.a:liblpeg.a:' falco/CMakeLists.txt || die
sed -i -e 's:cares/ares.h:ares.h:' falco/CMakeLists.txt || die
#	sed -i -e 's:“:":' falco/CMakeLists.txt || die
#	sed -i -e 's:”:":' falco/CMakeLists.txt || die
	sed -i -e 's:\${CIVETWEB_INCLUDE_DIR}:/usr/include/civetweb:' falco/userspace/falco/CMakeLists.txt || die

	#eapply "${FILESDIR}"/sysdig-0.26.0-build-fixes.patch
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# we will use linux-mod for that
		-DBUILD_DRIVER=OFF
		-DSYSDIG_DIR=${S}/sysdig
		# libscap examples are not installed or really useful
		-DBUILD_LIBSCAP_EXAMPLES=OFF

		# unbundle the deps
		-DUSE_BUNDLED_DEPS=OFF
	)

	cmake-utils_src_configure

	# setup linux-mod ugliness
	MODULE_NAMES="sysdig-probe(extra:${S}/driver:)"
	BUILD_PARAMS='KERNELDIR="${KERNEL_DIR}"'
	BUILD_TARGETS="all"

#	if use modules; then
##		cmake-utils_src_make configure_driver
##
##		cp "${BUILD_DIR}"/driver/Makefile.dkms driver/Makefile || die
#	fi
}

src_compile() {
	append-ldflags -lcurl
	cmake-utils_src_compile

	linux-mod_src_compile
}

src_install() {
	cmake-utils_src_install

	linux-mod_src_install

	# remove sources
	rm -r "${ED}"/usr/src || die

	# move bashcomp to the proper location
	dobashcomp "${ED}"/usr/etc/bash_completion.d/sysdig || die
	rm -r "${ED}"/usr/etc || die
}
