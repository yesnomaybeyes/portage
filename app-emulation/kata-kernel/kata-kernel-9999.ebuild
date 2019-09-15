EAPI=6



#EGO_PN="github.com/kata-containers/runtime"

#EGO_PN="github.com/kata-containers/runtime"
EGIT_REPO_URI="https://github.com/kata-containers/packaging"
inherit git-r3

RDEPEND="=app-misc/yq-2.3.0  app-arch/makeself"
DEPEND="${RDEPEND}"


DESCRIPTION="kata-containers kernel"

#LICENSE="ISC"
SLOT="0"
KEYWORDS=""


src_prepare() {
	default
}

src_compile() {
	echo skipped
}

##	pushd rootfs-builder
##	#GOPATH="${S}" emake BINDIR="${D}/usr/bin" DESTDIR="${D}/usr"
##	ROOTFS_DIR="${S}"
##	GOPATH="${S}" AGENT_INIT=yes  SECCOMP=yes ./rootfs.sh alpine
##	popd
##	pushd initrd-builder
##	AGENT_INIT=yes  ./initrd_builder.sh ${ROOTFS_DIR}
#}
#
src_install() {
	#GOPATH="${S}" emake  DESTDIR="${D}" BINDIR="/usr/bin" install
	mkdir -p ${D}/usr/bin
	cp ${FILESDIR}/run.sh ${S}/run.sh
	makeself "${S}" "${D}/usr/bin/kata-kernelb" "kata-kernelbuilder" "./run.sh"
}
