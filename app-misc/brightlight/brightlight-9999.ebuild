# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="command line date and time utilities"
HOMEPAGE="https://github.com/multiplexd/brightlight.git"
EGIT_REPO_URI="https://github.com/multiplexd/brightlight.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"


src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	dobin brightlight

}
