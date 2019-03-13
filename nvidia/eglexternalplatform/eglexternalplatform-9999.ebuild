# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="egl ext interface"
HOMEPAGE="https://github.com/NVIDIA/eglexternalplatform"
EGIT_REPO_URI="https://github.com/NVIDIA/eglexternalplatform"
inherit git-r3

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
insinto "/usr/include/EGL"
doins interface/eglexternalplatform.h
doins interface/eglexternalplatformversion.h
insinto "/usr/lib/pkgconfig"
doins eglexternalplatform.pc
}
