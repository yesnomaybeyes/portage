EAPI=6




EGO_PN="github.com/kata-containers/proxy"
inherit golang-vcs

RDEPEND="=app-misc/yq-2.3.0"
DEPEND="${RDEPEND}"


DESCRIPTION="kata-containers proxy"

LICENSE="apache2.0"
SLOT="0"
KEYWORDS=""


# src_prepare() {
# 	default
# # 	kt=src/github.com/kata-containers/runtime/
# # 		mkdir -p src/bin/
# # 		cp /usr/bin/yq src/bin/
# # 		cp ${FILESDIR}/golang.mk $kt/golang.mk
# # #sed -i '/  have_yq=/s,,have_yq=y,' src/github.com/kata-containers/runtime/golang.mk

# }

src_compile() {
	cd "${S}/src/github.com/kata-containers/proxy"
	#GOPATH="${S}" emake BINDIR="${D}/usr/bin" DESTDIR="${D}/usr"
	GOPATH="${S}" emake  DESTDIR="${D}/usr"
}

src_install() {
	cd "${S}/src/github.com/kata-containers/proxy"
	GOPATH="${S}" emake  DESTDIR="${D}" BINDIR="/usr/bin" install
}
