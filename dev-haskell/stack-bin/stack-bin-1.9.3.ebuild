# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The Haskell Tool Stack (Binary)"
HOMEPAGE="https://github.com/commercialhaskell/stack"

uri() {
	echo "https://github.com/commercialhaskell/stack/releases/download/v${PV}/stack-${PV}-linux-$1.tar.gz"
}

SRC_URI="
	arm? ( $(uri arm) )
	x86? ( $(uri i386) )
	amd64? ( $(uri x86_64) )
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="symlink"

DEPEND=""
RDEPEND="${DEPEND}
	sys-libs/zlib
	dev-libs/gmp:0
"
RDEPEND+=" symlink? ( !dev-haskell/stack )"

S=${WORKDIR}

QA_PREBUILT="/usr/bin/stack-bin"
QA_PRESTRIPPED="/usr/bin/stack-bin"

src_prepare() {
	default

	mv stack-${PV}-*/doc doc || die
	mv stack-${PV}-*/stack stack-bin || die
}

src_install() {
	dobin stack-bin
	use symlink && dosym stack-bin /usr/bin/stack
}
