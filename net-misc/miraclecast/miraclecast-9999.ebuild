# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools git-r3

DESCRIPTION="Wifi-Display/Miracast Implementation"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/miracle/"
EGIT_REPO_URI="https://github.com/albfan/miraclecast"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-libs/glib-2.38:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}
