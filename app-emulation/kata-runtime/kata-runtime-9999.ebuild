EAPI=6



#EGO_PN="github.com/kata-containers/runtime"

EGO_PN="github.com/kata-containers/runtime"
#EGIT_REPO_URI="https://github.com/kata-containers/runtime"
inherit z-golang-vcs linux-info

RDEPEND="=app-misc/yq-2.3.0 app-emulation/qemu app-emulation/kata-shim app-emulation/kata-proxy app-emulation/kata-osbuilder"
DEPEND="${RDEPEND}"

CONFIG_CHECK="~VSOCKETS"

DESCRIPTION="kata-containers runtime"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""


src_prepare() {
	default
	kt=src/github.com/kata-containers/runtime/
		mkdir -p src/bin/
		cp /usr/bin/yq src/bin/
		cp ${FILESDIR}/golang.mk $kt/golang.mk

}

src_compile() {
	cd "${S}/src/github.com/kata-containers/runtime"
	GOPATH="${S}" emake  DESTDIR="${D}/usr"
}

src_install() {
	cd "${S}/src/github.com/kata-containers/runtime"
	GOPATH="${S}" emake  DESTDIR="${D}" BINDIR="/usr/bin" install
}

pkg_setup() {
linux-info_pkg_setup
}

pkg_postinst() {
  elog
  elog "To use Kata, the kernel and rootfs needs to be built. A self-packing script has been included to do this for you."
  elog "Please run:"
  elog "   kata-osbuilder"
  elog "   kata-kernelb"
}