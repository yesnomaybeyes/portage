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
#sed -i '/  have_yq=/s,,have_yq=y,' src/github.com/kata-containers/runtime/golang.mk

}

src_compile() {
	cd "${S}/src/github.com/kata-containers/runtime"
	#GOPATH="${S}" emake BINDIR="${D}/usr/bin" DESTDIR="${D}/usr"
	GOPATH="${S}" emake  DESTDIR="${D}/usr"
}

src_install() {
	cd "${S}/src/github.com/kata-containers/runtime"
	GOPATH="${S}" emake  DESTDIR="${D}" BINDIR="/usr/bin" install
	cd $S/src/github.com/kata-containers/osbuilder/initrd-builder
	install -o root -g root -m 0640 -D kata-containers-initrd.img "${D}/usr/share/kata-containers/kata-containers-initrd.img"
}
