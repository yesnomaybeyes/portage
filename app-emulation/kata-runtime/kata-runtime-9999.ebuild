EAPI=6



#EGO_PN="github.com/kata-containers/runtime"

EGO_PN="github.com/kata-containers/runtime"
#EGIT_REPO_URI="https://github.com/kata-containers/runtime"
inherit z-golang-vcs

RDEPEND="=app-misc/yq-2.3.0 app-emulation/qemu"
DEPEND="${RDEPEND}"


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
